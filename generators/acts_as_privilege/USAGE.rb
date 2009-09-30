Description:
    Creates Entity (representing controllers) and Ability (representing
    controller actions) models, and then links them with any roles that your
    application users might need.

Usage:
    Pass the name of the model that you want to apply privileges.

Examples:
    script/generate acts_as_privilege Role

        Will expand roles with privileges.  Then you can manage user roles
        and attributed privileges for each one.

    script/generate acts_as_privilege Group

        Same, with the Group model.
