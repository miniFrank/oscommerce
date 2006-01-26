<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2006 osCommerce

  Released under the GNU General Public License
*/

  class osC_Boxes_tell_a_friend extends osC_Modules {
    var $_title,
        $_code = 'tell_a_friend',
        $_author_name = 'osCommerce',
        $_author_www = 'http://www.oscommerce.com',
        $_group = 'boxes';

    function osC_Boxes_tell_a_friend() {
      global $osC_Language;

      $this->_title = $osC_Language->get('box_tell_a_friend_heading');
    }

    function initialize() {
      global $osC_Language, $osC_Template, $osC_Product;

      if (isset($osC_Product) && is_a($osC_Product, 'osC_Product') && ($osC_Template->getModule() != 'tell_a_friend')) {
        $this->_content = '<form name="tell_a_friend" action="' . tep_href_link(FILENAME_PRODUCTS, 'tell_a_friend&' . $osC_Product->getKeyword()) . '" method="post">' . "\n" .
                          osc_draw_input_field('to_email_address', '', 'style="width: 80%;"') . '&nbsp;' . tep_image_submit('button_tell_a_friend.gif', $osC_Language->get('box_tell_a_friend_text')) . '<br />' . $osC_Language->get('box_tell_a_friend_text') . "\n" .
                          '</form>' . "\n";
      }
    }
  }
?>
