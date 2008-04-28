require File.dirname(__FILE__) + '/../../../test_helper'

class DibsHelperTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def setup
    @helper = Dib::Helper.new('order_id','merchant_id', :amount => 500, :currency => 'nok')
  end
 
  def test_basic_helper_fields
    assert_field 'merchant', 'merchant_id'
    assert_field 'orderid', 'order_id'
    assert_field 'amount', '500'
    assert_field 'currency', '578'
  end
  
  def test_customer_fields
    @helper.customer :name => 'Winnie The Pooh'#, :last_name => 'Fauser', :email => 'cody@example.com'
    assert_field 'delivery1.Navn', 'Winnie The Pooh'
  end

  def test_address_mapping
    @helper.billing_address :street => '1 My Street'
    assert_field 'delivery2.Adresse', '1 My Street'
  end
  
  def test_currency_map
    @helper.currency_code = :nok
    assert_field 'currency', '578'
    @helper.currency_code = :dkk
    assert_field 'currency', '208'
  end
  
  def test_other_fields
    @helper.instant_capture = true
    assert_field 'capturenow','true'
    @helper.description = "This is a test"
    assert_field 'ordertext', 'This is a test'

    @helper.decorator = "invalid"
    assert_field 'decorator', nil

    @helper.decorator = "default"
    assert_field 'decorator', 'default'
    @helper.decorator = "basal"
    assert_field 'decorator', 'basal'
    @helper.decorator = "rich"
    assert_field 'decorator', 'rich'
  end
  
  
end
