# frozen_string_literal: true

class Forms::TextComponent < ViewComponent::Base
  def initialize(form:, attribute:, help:, label: nil)
    @form = form
    @attribute = attribute
    @label = label
    @help = help
    @input_cx = input_cx
    @has_error = has_error
    @error_message = error_message
  end

  private

  def has_error
    @form.object.errors.has_key?(@attribute)
  end

  def input_cx
    has_error ? 'form-control is-invalid' : 'form-control'
  end

  def error_message
    has_error ? @form.object.errors.full_messages_for(:name).join(' ') : nil
  end
end
