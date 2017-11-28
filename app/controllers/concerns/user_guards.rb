module UserGuards

  def ensure_signed_in
    unless signed_in?
      respond_to do |f|
        f.html { redirect_to new_sign_in_url, alert: t('navs.messages.ensure_signed_in') }
        f.js { head :forbidden }
      end
    end
  end

  def ensure_signed_out
    if signed_in?
      redirect_to home_url, notice: t('navs.messages.already_signed_in')
    end
  end
end
