require_relative "../../types"

module ClientSuccess
  module Schema
    module Client
      # TODO: upgrade dry types to use latest schema functions
      Create = Types::Hash.schema(
        name:                           Types::Strict::String,
        site_url:                       Types::Strict::String,
        zip:                            Types::Strict::String,
        status_id:                      Types::Coercible::Int,
        inception_date:                 Types::Strict::String, # TODO
        created_by_employee_id:         Types::Coercible::Int,
        linkedin_url:                   Types::Strict::String,
        managed_by_employee_id:         Types::Coercible::Int,
        active:                         Types::Strict::Bool,
        active_client_success_cycle_id: Types::Coercible::Int,
        zendesk_id:                     Types::Coercible::String,
        desk_id:                        Types::Coercible::String,
        freshdesk_id:                   Types::Coercible::String,
        jira_id:                        Types::Coercible::String,
        terminated_date:                Types::Strict::String, # TODO
        assigned_sales_rep:             Types::Coercible::Int,
        salesforce_account_id:          Types::Coercible::String,
        usage_id:                       Types::Coercible::String,
        street:                         Types::Strict::String,
        state:                          Types::Strict::String,
        country:                        Types::Strict::String,
        city:                           Types::Strict::String,
        external_id:                    Types::Coercible::String
      )
    end
  end
end
