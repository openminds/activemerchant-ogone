require 'net/http'
# https://payment.architrade.com/cgi-bin/transinfo.cgi?merchant=<merchant_id>&orderid=<order_id>&currency=<currency_code>&amount=<amount>
# Returns transact=<transaction_id>&status=<status_code> where status code is one of
# 0 – rejected
# 1 – authorised
# 2 – captured.
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dib
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            !transaction_id.blank?
          end 

          def transaction_id
            params['transact']
          end

          # the money amount we received in X.2 decimal.
          def gross
            params['amount']
          end

          # Was this a test transaction?
          def test?
            params['test'] == 'test'
          end
          
          def site_id
            params['merchant']
          end
          
          def order_id
            params['orderid']
          end
          
          def currency
            params['currency']
          end


 private

          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post
            for line in post.split('&')
              key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
              params[key] = value
            end
          end
        end
      end
    end
  end
end
