module Authentication::ByOpenId
  
   
  # Pass optional :required and :optional keys to specify what sreg fields you want.
  # Be sure to yield registration, a third argument in the #authenticate_with_open_id block.
  # REMEMBER: a "required" field is not guaranteed to be returned by OpenID provider
  def login_from_open_id
    p "hi there"
    #return nil unless params[:openid_url]
    params[:openid_url] = params[:openid_url].strip if params[:openid_url]
    authenticate_with_open_id(params[:openid_url], 
    :required => [ :nickname ],
    :optional => [ :email, :fullname ]) do |result, identity_url, registration|
      if result.successful?
        #registration[:identity_url] = identity_url
        User.find_by_identity_url(identity_url)
      else
        nil
      end
    end
  end
  
  #hooks into login chain at higher priority
  def try_login_chain_with_open_id
    login_from_open_id || try_login_chain_without_open_id
  end
  
  def logout_chain_with_open_id
    # Nothing Yet
    logout_chain_without_open_id
  end
  
  #
  # Plumbing
  #
  def self.included( recipient )
    recipient.alias_method_chain(:try_login_chain,  :open_id) unless recipient.instance_methods.include?('try_login_chain_without_open_id')
    recipient.alias_method_chain(:logout_chain,     :open_id) unless recipient.instance_methods.include?('logout_chain_without_open_id')
  end
  
  private
  def denormalized_url(url)
    return url.gsub(%r{^https?://}, '').gsub(%r{/$},'')
  end

  def normalize_url(url)
    return OpenIdAuthentication.normalize_url(url)
  end
  
  
end
 
module Identity::OpenId
  def self.included( recipient )
    #recipient.extend( ClassMethods )
    recipient.class_eval do
       validates_presence_of :identity_url,                 :if => :open_id_validation_required?
       attr_accessible :identity_url
    end
  end
  
  private
  #TODO: figure out how to chain validations when only one authentication method is required
  def open_id_validation_required?
    false
  end
end