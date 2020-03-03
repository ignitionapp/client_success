require_relative "../../types"

module ClientSuccess
  module Schema
    module Client
      # TODO: upgrade dry types to use latest schema functions
      Update = Types::Hash.schema(
        external_id:                    Types::Coercible::String,
        name:                           Types::Strict::String,
        site_url:                       Types::Strict::String,
        client_segment_id:              Types::Coercible::Int,
        zip:                            Types::Strict::String,
        modified_by_employee_id:        Types::Coercible::Int,
        status_id:                      Types::Coercible::Int,
        inception_date:                 Types::Strict::String, # TODO
        created_by_employee:            Types::Coercible::Int,
        linkedin_url:                   Types::Strict::String,
        managed_by_employee_id:         Types::Coercible::Int,
        active:                         Types::Strict::Bool,
        success_score:                  Types::Strict::Int,
        active_client_success_cycle_id: Types::Coercible::Int,
        crm_customer_id:                Types::Coercible::String,
        crm_customer_url:               Types::Strict::String,
        zendesk_id:                     Types::Coercible::String,
        desk_id:                        Types::Coercible::String,
        freshdesk_id:                   Types::Coercible::String,
        uservoice_id:                   Types::Coercible::String,
        assigned_sales_rep:             Types::Strict::String,
        custom_field_values:            Types::Strict::Array.default([]), # TODO
        success_cycle_id:               Types::Coercible::Int,
        salesforce_account_id:          Types::Coercible::String,
        jira_id:                        Types::Coercible::String,
        nps_score:                      Types::Strict::Int
      )
    end
  end
end
