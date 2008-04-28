require File.dirname(__FILE__) + '/../../../test_helper'

class DibNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @dibs = Dib::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @dibs.complete?
    assert_equal "2345", @dibs.transaction_id
    assert_equal "111", @dibs.order_id
    assert_equal "22", @dibs.gross
    assert_equal "578", @dibs.currency
    assert @dibs.test?
  end

  private
  def http_raw_data
    "transact=2345&orderid=111&amount=22&currency=578&test=test"
  end  
end
