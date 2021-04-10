require 'test_helper'

class Forms::InputComponentTest < ViewComponent::TestCase
  class Form
    include ActionView::Helpers::FormHelper

    def initialize(object)
      @object = object
    end

    attr_accessor :object
  end

  test 'renders a labeled number input for numeric attributes' do
    score = Score.new
    form = Form.new(score)
    render_inline(
      Forms::InputComponent.new(
        form: form,
        attribute: :value,
        help: 'Put the score here',
        label: 'Scoooooore',
      ),
    )

    assert_text('Scoooooore')
    assert_text('Put the score here')
    assert_equal true, page.has_field?(nil, type: 'number')
  end
end
