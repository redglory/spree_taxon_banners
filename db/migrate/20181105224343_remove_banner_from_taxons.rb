class RemoveBannerFromTaxons < ActiveRecord::Migration[5.2]
  def change
  	remove_column :spree_taxons, :banner_file_name if column_exists? :spree_taxons, :banner_file_name
    remove_column :spree_taxons, :banner_content_type if column_exists? :spree_taxons, :banner_content_type
    remove_column :spree_taxons, :banner_file_size if column_exists? :spree_taxons, :banner_file_size
    remove_column :spree_taxons, :banner_updated_at if column_exists? :spree_taxons, :banner_updated_at
  end
end
