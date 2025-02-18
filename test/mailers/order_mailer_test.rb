require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
   mail = OrderMailer.received(orders(:one))
   assert_equal "Pragmatic Store Order Confirmation", mail.subject
   assert_equal ["dave@example.org"], mail.to
   assert_equal ["depot@example.com"], mail.from
   assert_match /1 x Programming Ruby 1.9/, mail.body.encoded
  end

  test "shipped" do
     mail = OrderMailer.shipped(orders(:one))
   
     assert_equal "Pragmatic Store Order Shipped", mail.subject
     assert_equal ["dave@example.org"], mail.to
     assert_equal ["depot@example.com"], mail.from
     html_body = mail.body.parts.find { |part| part.content_type.match?("text/html") }&.decoded || mail.body.decoded

     doc = Nokogiri::HTML(html_body)
     row = doc.at('table tr:nth-child(2)')
  
     cells = row.css('td').map(&:text)
     assert_equal ["1", "×", "Programming Ruby 1.9"], cells
    end

end
