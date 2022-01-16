class SolitaireController < ApplicationController
  def new
    @form = SolitaireForm.new
  end

  def create
    form = SolitaireForm.new(solitaire_params)

    if form.valid?
      service = SolitaireService.new(form.file).call
      render turbo_stream: turbo_stream.replace('new_solitaire_form', partial: 'solitaire/download', locals: { path: service.output_file.path })
    else
      render turbo_stream: turbo_stream.replace('new_solitaire_form', partial: 'solitaire/form', locals: { form: form })
    end
  end

  def download_output
    if File.exist?(params[:path])
      send_file File.open(params[:path])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def solitaire_params
    params.require(:solitaire_form).permit(:file)
  end
end