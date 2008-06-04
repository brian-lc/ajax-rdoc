#!/bin/sh
RDOC_GEN="/usr/local/lib/ruby/1.8/rdoc/generators/ajax_generator.rb"
RDOC_TPL="/usr/local/lib/ruby/1.8/rdoc/generators/template/ajax"
CURRENT_PATH="/Users/tiendung/code/ajax-rdoc" # pwd

sudo rm $RDOC_GEN
sudo rm -r $RDOC_TPL

sudo ln -s $CURRENT_PATH/rdoc/generators/ajax_generator.rb $RDOC_GEN
sudo ln -s $CURRENT_PATH/rdoc/generators/template/ajax $RDOC_TPL
