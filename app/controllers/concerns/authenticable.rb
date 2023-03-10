# frozen_string_literal: true

module Authenticable
  def current_user
    return @current_user if @curretn_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    @current_user =  User.find(decoded[:user_id]) rescue 
      ActiveRecord::RecordNotFound
    
  end
end
