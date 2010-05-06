class ResponsesResult < ActiveRecord::Base
  belongs_to :response
  belongs_to :result
end