# frozen_string_literal: true

class FormInputComponent < ViewComponent::Base
  def initialize(form:, model:, attribute:, help:)
    @form = form
    @model = model
    @attribute = attribute
    @help = help
    @input_cx = input_cx
    @has_error = has_error
    @error_message = error_message
  end

  private

  def has_error
    @model.errors.has_key?(@attribute)
  end

  def input_cx
    has_error ? 'form-control is-invalid' : 'form-control'
  end

  def error_message
    has_error ? @model.errors.full_messages_for(:name).join(' ') : nil
  end
end
