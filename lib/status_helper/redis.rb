module StatusHelper
  module Redis
    def store_status(user, message)
      redis.hset format_status(user), 'message', "#{message} -- #{Time.new}"
    end

    def fetch_status(user)
      redis.hget format_status(user), 'message'
    end

    def delete_status(user)
      redis.hdel format_status(user), 'message'
    end

    def store_password(user, password)
      redis.hset format_status(user), 'password', password
    end

    def fetch_password(user)
      redis.hget format_status(user), 'password'
    end

    def remove_password(user)
      redis.hdel format_status(user), 'password'
    end

    def format_status(user)
      "status_#{user.id}"
    end

    def retrieve_keys
      redis.keys 'status_*'
    end
  end
end
