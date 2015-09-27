Deface::Override.new(:virtual_path => "spree/admin/taxons/_form",
                     :name => "add_banner_to_taxon_form",
                     :insert_bottom => "[data-hook='admin_inside_taxon_form'] .col-md-7",
                     :partial => "spree/admin/taxons/banner")