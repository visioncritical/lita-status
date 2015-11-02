module Lita
  module Handlers
    class Status < Handler
      include ::StatusHelper::Redis
      include ::StatusHelper::Regex
      include ::StatusHelper::Utility

      route(
        /\Astatus\sset\s#{STATUS_PATTERN}\z/,
        :set,
        command: true,
        help: { t('help.set.syntax') => t('help.set.desc') }
      )

      route(
        /\Astatus\son\sbehalf\sset\s#{USER_PATTERN}\s#{PASSWORD_PATTERN}\s#{STATUS_PATTERN}\z/,
        :on_behalf_set,
        command: true,
        help: { t('help.on_behalf_set.syntax') => t('help.on_behalf_set.desc') }
      )

      route(
        /\Astatus\sget(|\s#{USER_PATTERN})\z/,
        :get,
        command: true,
        help: { t('help.get.syntax') => t('help.get.desc') }
      )

      route(
        /\Astatuses\z/,
        :statuses,
        command: true,
        help: { t('help.get_all.syntax') => t('help.get_all.desc') }
      )

      route(
        /\Astatus\sremove\z/,
        :remove,
        command: true,
        help: { t('help.remove.syntax') => t('help.remove.desc') }
      )

      route(
        /\Astatus\son\sbehalf\sremove\s#{USER_PATTERN}\s#{PASSWORD_PATTERN}\z/,
        :on_behalf_remove,
        command: true,
        help: { t('help.on_behalf_remove.syntax') => t('help.on_behalf_remove.desc') }
      )

      route(
        /\Astatus\spassword\sset\s#{PASSWORD_PATTERN}\z/,
        :password_set,
        command: true,
        help: { t('help.password_set.syntax') => t('help.password_set.desc') }
      )

      route(
        /\Astatus\spassword\sremove\z/,
        :password_remove,
        command: true,
        help: { t('help.password_remove.syntax') => t('help.password_remove.desc') }
      )

      def set(response, lita_user = nil)
        status = response.match_data['status']
        # Set user to the calling user if nil
        lita_user ||= response.user
        store_status lita_user, status
        response.reply t('set.new', name: lita_user.name)
      end

      # Allows your status to be set by bots (EX: IFTTT)
      def on_behalf_set(response)
        lita_user = find_user response.match_data['user']
        return response.reply t('error.no_user', name: lita_user.name) if lita_user.nil?
        stored_password = fetch_password lita_user
        if stored_password.eql? response.match_data['password']
          return set response, lita_user
        end
        return response.reply t('error.password_nil', action: 'set', name: lita_user.name) if stored_password.nil?
        response.reply t('error.password_mistmatch', action: 'set', name: lita_user.name)
      end

      def get(response)
        lita_user = find_user response.match_data['user']
        if lita_user.nil? && !response.match_data['user'].nil?
          return response.reply t('error.no_user', name: response.match_data['user'])
        end
        # If lita_user is nil, we're getting our own status
        lita_user ||= response.user
        status = fetch_status lita_user
        return response.reply t('error.no_status', name: lita_user.name) if status.nil?
        response.reply t('get', name: lita_user.name, status: status)
      end

      def statuses(response)
        ids = retrieve_keys
        ids.each do |id|
          lita_user = find_user id.gsub('status_', ''), :find_by_id
          status = fetch_status lita_user
          if status.nil?
            response.reply t('error.no_status', name: lita_user.name) 
          else
            response.reply t('get', name: lita_user.name, status: status)
          end
        end
      end

      def remove(response)
        delete_status response.user
        response.reply t('remove', name: response.user.name)
      end

      # Allows your status to be removed by bots (EX: IFTTT)
      def on_behalf_remove(response)
        lita_user = find_user response.match_data['user']
        return response.reply t('error.no_user', name: lita_user.name) if lita_user.nil?
        stored_password = fetch_password lita_user
        if stored_password.eql? response.match_data['password']
          delete_status lita_user
          return response.reply t('remove', name: lita_user.name)
        end
        return response.reply t('error.password_nil', action: 'remove', name: lita_user.name) if stored_password.nil?
        response.reply t('error.password_mistmatch', action: 'remove', name: lita_user.name)
      end

      def password_set(response)
        store_password response.user, response.match_data['password']
        response.reply_privately t('password.set', name: response.user.name)
      end

      def password_remove(response)
        remove_password response.user
        response.reply_privately t('password.remove', name: response.user.name)
      end
    end
    Lita.register_handler Status
  end
end
