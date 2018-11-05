class AddAttachmentBannerToSpreeTaxons < ActiveRecord::Migration[5.0]
  def change
    add_attachment :spree_taxons, :banner
  end
end
