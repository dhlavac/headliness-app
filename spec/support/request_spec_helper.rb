module RequestSpecHelper
  # Parse json to hash
  def json
    JSON.parse(response.body)
  end
end