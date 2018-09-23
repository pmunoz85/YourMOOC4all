# -*- encoding : utf-8 -*-
# Desactivamos el orden de prelación cuando el usuario no está registrado
#  class CustomFailure < Devise::FailureApp
#    def redirect_url
#       new_user_registration_url #(:subdomain => 'secure')
#    end

    # You need to override respond to eliminate recall
#    def respond
#      if http_auth?
#        http_auth
#      else
#        redirect
#      end
#    end
#  end

