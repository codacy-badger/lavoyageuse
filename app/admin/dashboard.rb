ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
  #   div class: "blank_slate_container", id: "dashboard_default_message" do
  #     span class: "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
  #   end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Users" do
          ul do
            User.last(5).map do |user|
              li
                span do
                  span link_to(user.first_name, admin_user_path(user))
                  span "- " + user.last_name
                  span "- " + user.address
                end
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end

      column do
        panel "Recent Comments" do
          ul do
            Comment.last(5).map do |comment|
              li
                span do
                  span link_to(comment.content, admin_comment_path(comment))
                end
            end
          end
        end
      end

      column do
        panel "Recent Moderation" do
          ul do
            Moderation.last(5).map do |moderation|
              li
                span do
                  span moderation.moderator.first_name + " : "
                  span link_to(moderation.action, admin_moderation_path(moderation))
                end
            end
          end
        end
      end
    end
  end # content
  end
