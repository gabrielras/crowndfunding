module EnabledClient
  private

  def profile_is_complete?(current_store)
    if current_client.profile.present?
      return true if current_client.profile.bank_id && current_client.profile.recipient_id
    end
    false
  end
end
