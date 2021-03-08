# frozen_string_literal: true

class Forms::InputComponent < ViewComponent::Base
  def initialize(form:, attribute:, help:, label: nil)
    @form = form
    @attribute = attribute
    @label = label
    @help = help
    @input_cx = input_cx
    @has_error = has_error
    @error_message = error_message
    @field_type = field_type
  end

  private

  def has_error
    @form.object.errors.has_key?(@attribute)
  end

  def input_cx
    has_error ? 'form-control is-invalid' : 'form-control'
  end

  def error_message
    if has_error
      @form.object.errors.full_messages_for(@attribute).join(' ')
    else
      nil
    end
  end

  # Return :text_field or :number_field
  def field_type
    type = @form.object.class.columns_hash[@attribute.to_s].type
    return :text_field if type == :string
    return :number_field
  end
end
