require "faraday"
require "faraday_middleware"

module ClientSuccess
  class Connection
    class Error < StandardError; end

    class BadRequest < Error; end
    class Unauthorised < Error; end
    class NotFound < Error; end

    class ParsingError < Error; end
    class ConnectionError < Error; end

    class << self
      def authorised(access_token)
        new.tap { |conn| conn.access_token = access_token }
      end
    end

    def logger
      # TODO: something better than this
      Logger.new(STDOUT).tap do |l|
        l.level = Logger::WARN
      end
    end

    def access_token
      headers["Authorization"]
    end

    def access_token=(access_token)
      headers["Authorization"] = access_token
    end

    def get(path, headers = {}, &block)
      request { adapter.get(path, headers, &block) }
    end

    def head(path, headers = {}, &block)
      raise NotImplementedError
    end

    def post(path, body = nil, headers = {}, &block)
      request { adapter.post(path, body, headers, &block) }
    end

    def put(path, body = nil, headers = {}, &block)
      request { adapter.put(path, body, headers, &block) }
    end

    def patch(path, body = nil, headers = {}, &block)
      request { adapter.patch(path, body, headers, &block) }
    end

    def delete(path, headers = {}, &block)
      request { adapter.delete(path, headers, &block) }
    end

    def options(path, headers = {}, &block)
      raise NotImplementedError
    end

    private

    def headers
      adapter.headers
    end

    def adapter
      @adapter ||= Faraday.new(url: "https://api.clientsuccess.com") do |faraday|
        faraday.request(:json)
        faraday.response(:json, content_type: /\bjson$/)
        faraday.response(:logger, logger)
        faraday.use(Faraday::Response::RaiseError)
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def request
      yield
    rescue Faraday::ParsingError => error
      raise ParsingError, error
    rescue Faraday::ClientError => error
      case error.response[:status]
      when 400
        # TODO: parse out userMessage from the response here
        raise BadRequest, error
      when 401
        raise Unauthorised, error
      when 404
        raise NotFound, error
      else
        raise Error, error
      end
    rescue Faraday::ConnectionFailed => error
      raise ConnectionError, error
    rescue SignalException => error
      raise Error, error
    end
  end
end
