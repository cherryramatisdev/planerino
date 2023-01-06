# typed: true

extend T::Sig
sig { returns(T.nilable(User)) }
def current_user; end
