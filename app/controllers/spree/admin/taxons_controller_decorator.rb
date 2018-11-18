Spree::Admin::TaxonsController.class_eval do

  def create
    @taxon = @taxonomy.taxons.build(params[:taxon].except(*[:icon, :banner]))
    @taxon.build_icon(attachment: taxon_params[:icon])
    @taxon.build_banner(attachment: taxon_params[:banner])
    if @taxon.save
      respond_with(@taxon) do |format|
        format.json { render json: @taxon.to_json }
      end
    else
      flash[:error] = Spree.t('errors.messages.could_not_create_taxon')
      respond_with(@taxon) do |format|
        format.html { redirect_to @taxonomy ? edit_admin_taxonomy_url(@taxonomy) : admin_taxonomies_url }
      end
    end
  end

  def update
    successful = @taxon.transaction do
      parent_id = params[:taxon][:parent_id]
      set_position
      set_parent(parent_id)

      @taxon.save!

      # regenerate permalink
      regenerate_permalink if parent_id

      set_permalink_params

      # check if we need to rename child taxons if parent name or permalink changes
      @update_children = true if params[:taxon][:name] != @taxon.name || params[:taxon][:permalink] != @taxon.permalink

      @taxon.create_icon(attachment: taxon_params[:icon]) if taxon_params[:icon]
      @taxon.create_banner(attachment: taxon_params[:banner]) if taxon_params[:banner]
      @taxon.update_attributes(taxon_params.except(*[:icon, :banner]))
    end
    if successful
      flash[:success] = flash_message_for(@taxon, :successfully_updated)

      # rename child taxons
      rename_child_taxons if @update_children

      respond_with(@taxon) do |format|
        format.html { redirect_to edit_admin_taxonomy_url(@taxonomy) }
        format.json { render json: @taxon.to_json }
      end
    else
      respond_with(@taxon) do |format|
        format.html { render :edit }
        format.json { render json: @taxon.errors.full_messages.to_sentence, status: 422 }
      end
    end
  end

end