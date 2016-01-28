class SemanticUiRadioButtonsInput < SimpleForm::Inputs::CollectionRadioButtonsInput

  def input
    label_method, value_method = detect_collection_methods
    iopts = {
      :checked => 1,
      :item_wrapper_tag => 'div',
      :item_wrapper_class => 'field',
      :collection_wrapper_tag => 'div',
      :collection_wrapper_class => 'grouped inline fields'
    }
    @builder.send(
      "collection_radio_buttons",
      attribute_name,
      collection,
      value_method,
      label_method,
      iopts,
      input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    tag = String.new
    tag << '<div class="ui radio checkbox">'.html_safe
    tag << collection_builder.radio_button + collection_builder.label
    tag << '</div>'.html_safe
    tag.html_safe
  end # method

end # class
