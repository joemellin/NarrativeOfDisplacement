Rails.application.routes.draw do
  root to: 'visitors#index'

  post '/twilio/receive_call' => 'twilio#receive_call', :as => 'receive_call_twilio'
  post '/twilio/receive_pin' => 'twilio#receive_pin', :as => 'receive_pin_twilio'
  post '/twilio/receive_main_decision_tree' => 'twilio#receive_main_decision_tree', :as => 'receive_main_decision_tree_twilio'
  post '/twilio/receive_community_connection' => 'twilio#receive_community_connection', :as => 'receive_community_connection_twilio'
  post '/twilio/receive_provider_group' => 'twilio#receive_provider_group', :as => 'receive_provider_group_twilio'
  match '/twilio/community_connection_call_ended' => 'twilio#community_connection_call_ended', :as => 'community_connection_call_ended_twilio', :via => [:get, :post]
  match '/twilio/receive_community_connection_after_call_options' => 'twilio#receive_community_connection_after_call_options', :as => 'receive_community_connection_after_call_options', :via => [:get, :post]
  post '/twilio/call_ended' => 'twilio#call_ended', :as => 'call_ended_twilio'
  post '/twilio/end_conference' => 'twilio#end_conference', :as => 'end_conference_twilio'
  post '/twilio/receive_sms' => 'twilio#receive_sms', :as => 'receive_sms_twilio'

end
