module PrivilegesHelper
  def privileges_field(resource, object_name = params[:controller].singularize)
    content_tag(:fieldset, :id => "#{object_name}_privileges") do
      content_tag(:legend, "Privileges") +
      content_tag(:p) do
        label(object_name, :ability_ids) +
        tag('br') + "\n" +
        select(object_name, "ability_ids",
          option_groups_from_collection_for_select(Entity.all, :abilities,
          :name, :id, :name, resource.abilities.collect { |ability| ability.id }),
          {}, {:multiple => 'multiple'})
      end
    end
  end
end
