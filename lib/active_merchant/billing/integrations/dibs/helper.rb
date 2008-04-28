# Country codes
# da = Danish (default)
# sv = Swedish
# no = Norwegian
# en = English
# nl = Dutch
# de = German
# fr = French
# fi = Finnish
# es = Spanish
# it = Italian
# fo = Faroese
# pl = Polish

# Credit card for testing
# 4711100000000000 06/24 684
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dib
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          
          def initialize(order, account, options = {})
            super
            self.currency_code = options[:currency]
          end
          
          mapping :billing_address, 
            :street     => 'delivery2.Adresse'
          mapping :customer, 
            :name       => 'delivery1.Navn'
          
          def billing_address(mapping = {})
            mapping.each do |k, v|
              field = mappings[:billing_address][k]
              add_field(field, v) unless field.nil?
            end 
          end   
          
          def customer(mapping = {})
            mapping.each do |k, v|
              field = mappings[:customer][k]
              add_field(field, v) unless field.nil?
            end 
          end     
          
          def currency_codes
            {
              :dkk  => '208',
              :eur  => '978',
              :usd  => '840',
              :gbp  => '826',
              :sek  => '752',
              :aud  => '036',
              :cad  => '124',
              :isk  => '352',
              :jpy  => '392',
              :nzd  => '554',
              :nok  => '578',
              :chf  => '756',
              :try  => '949'
            }.with_indifferent_access
          end
          
          def currency_code=(a_code)
            curr = currency_codes[a_code.to_s.downcase.to_sym]
            add_field(:currency, curr)
          end
          
          def decorator=(a_decorator)
            if %w(default basal rich).include?(a_decorator)
              add_field 'decorator', a_decorator
            end
          end
          
          
          mapping :account, 'merchant'
          mapping :amount, 'amount'
        
          mapping :order, 'orderid'

          mapping :test, "test"
          mapping :currency, "currency"
          mapping :language, 'lang'

          mapping :calculate_fee, 'calcfee'
          
          mapping :notify_url, 'callbackurl'
          mapping :return_url, 'accepturl'
          mapping :cancel_return_url, 'cancelurl'
          mapping :description, 'ordertext'
          mapping :decorator, 'decorator'
          mapping :tax, 'priceinfo2.VAR'
          mapping :shipping, 'priceinfo1.shippingcosts'
          mapping :instant_capture, 'capturenow'
        end
      end
    end
  end
end
