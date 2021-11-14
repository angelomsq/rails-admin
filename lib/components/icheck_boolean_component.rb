# custom component requires input group wrapper
module IcheckBoolean
  def icheck(wrapper_options = nil)
    options[:icheck].to_s.html_safe
  end

end

# Register the component in Simple Form.
SimpleForm.include_component(IcheckBoolean)