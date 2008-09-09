# Ogone Integration developed by Openminds (www.openminds.be)
# For problems contact us at ogone@openminds.be
require File.dirname(__FILE__) + '/ogone/helper.rb'
require File.dirname(__FILE__) + '/ogone/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Ogone 
        ActiveMerchant::Billing::Base.mode = :test

        TEST_URL = 'https://secure.ogone.com/ncol/test/orderstandard.asp'
        LIVE_URL = 'https://secure.ogone.com/ncol/prod/orderstandard.asp'

        mattr_accessor :service_url
        class << self
          def service_url
            case ActiveMerchant::Billing::Base.integration_mode
            when :test
              TEST_URL
            when :production
              LIVE_URL
            end
          end

          def notification(post, options)
            Notification.new(post, options)
          end

          def SHASign_out(fields, signature)
            keys = ['orderID','amount','currency','PSPID']
            datastring = keys.collect{|key| fields[key]}.join('')
            Digest::SHA1.hexdigest("#{datastring}#{signature}").upcase
          end          

          def SHASign_in(fields, signature)
            keys = ['orderID','currency','amount','PM','ACCEPTANCE','STATUS','CARDNO','PAYID','NCERROR','BRAND']
            datastring = keys.collect{|key| fields[key]}.join('')
            Digest::SHA1.hexdigest("#{datastring}#{signature}").upcase
          end 
        end         
      end
    end
  end

  class OgoneError < ActiveMerchantError; end
end

