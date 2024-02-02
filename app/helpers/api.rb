class Api
  def initialize(
    auth_key = 'ASERq34gaSRGAsdfa23afsd',
    endpoint = 'https://api.deepl.com/v2/glossaries'
  )
    @auth_key = auth_key
    @endpoint = endpoint
  end

  def self.default
    @default ||= new
  end

  def submit(glossary)
    post = create_post(glossary)
    uri = URI(@endpoint)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(post)
    end
    if res == Net::HTTPSuccess
      JSON.parse(res.body)
    else
      # TODO: check for proper escaping here
      err = JSON.parse(res.body)['message']
      raise ApiError.new, err
    end
  end

  def create_post(glossary)
    post = Net::HTTP::Post.new(@endpoint)
    post.content_type = 'application/json'
    post['Authorization'] = "DeepL-Auth-Key #{@auth_key}"
    post.body = glossary.as_json
    post
  end

  def delete(deep_l_glossary)
    delete = Net::HTTP::Delete.new("#{@endpoint}/#{deep_l_glossary.glossary_id}")
    delete['Authorization'] = "DeepL-Auth-Key #{@auth_key}"
    
    uri = URI(@endpoint)
    res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      http.request(delete)
    end
    if res == Net::HTTPSuccess
      res
    else
      # TODO: check for proper escaping here
      err = JSON.parse(res.body)['message']
      raise ApiError.new, err
    end
  end
end

class ApiError < StandardError
end
