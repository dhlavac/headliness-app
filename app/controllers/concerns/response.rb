module Response
  def json_response(object, status = :ok)
    render json:object, status:status
  end

  def process_success(hash = {}, object)
    hash[:object] ||= instance_variable_get("@#{controller_name.singularize}")
    hash[:object_name] ||= hash[:object].to_s
    unless hash[:success_msg]
      hash[:success_msg] = case action_name
                           when "create"
                             "Successfully created %s." % hash[:object_name]
                           when "update"
                             "Successfully updated %s." % hash[:object_name]
                           when "destroy"
                             "Successfully deleted %s." % hash[:object_name]
                           else
                             raise Foreman::Exception.new("Unknown action name for success message: %s", action_name)
                           end
    end
    render json: {code: 200, message: hash[:success_msg], data: object}
  end

  def process_error(hash = {})
    hash[:object] ||= instance_variable_get("@#{controller_name.singularize}")

    hash[:error_msg] = [hash[:error_msg]].flatten.to_sentence
    render json: {status: "Error", code: 500, message: hash[:error_msg]}
  end

end
