class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
    if user.has_role? :administrador
        can :manage, :all
    end

    if user.has_role? :usuario
        can :read,       Curso
        cannot :destroy, Curso
        cannot :create,  Curso
        cannot :update,  Curso

        can :read,       Universidad
        cannot :destroy, Universidad
        cannot :create,  Universidad
        cannot :update,  Universidad

        can :read,       Proveedor
        cannot :destroy, Proveedor
        cannot :create,  Proveedor
        cannot :update,  Proveedor

        can :read,       Idioma
        cannot :destroy, Idioma
        cannot :create,  Idioma
        cannot :update,  Idioma

        can :read,       Audio
        cannot :destroy, Audio
        cannot :create,  Audio
        cannot :update,  Audio

        can :read,       Subtitulo
        cannot :destroy, Subtitulo
        cannot :create,  Subtitulo
        cannot :update,  Subtitulo

        can :read,       Transcripcion
        cannot :destroy, Transcripcion
        cannot :create,  Transcripcion
        cannot :update,  Transcripcion

        can :read,       Evaluacion
        can :destroy, Evaluacion
        can :create,  Evaluacion
        can :update,  Evaluacion

        cannot :read,    User
        cannot :destroy, User
        cannot :create,  User
        cannot :update,  User
    end

    if user.has_role? :invitado
        cannot :read,    :all
        cannot :destroy, :all
        cannot :create,  :all
        cannot :update,  :all
    end



#    unless user_signed_in?
#        can :read,    Curso
#        can :read,    Universidad
#        can :read,    Idioma
#    end
  end
end
