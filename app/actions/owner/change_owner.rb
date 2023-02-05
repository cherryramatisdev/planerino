# frozen_string_literal: true

module Actions
  module Owner
    module ChangeOwner
      def self.call(to_owner_id:, origin_id:)
        @debit = Debit.find(origin_id)

        return @debit if @debit.update(owner_id: to_owner_id)

        nil
      end
    end
  end
end
