module GuestHandler

  def render_success_to_sign_up_or_in(result)
    if result.sign_up?
      render template: 'sign_ups/create'
    else
      render template: 'sign_ins/create'
    end
  end
end
