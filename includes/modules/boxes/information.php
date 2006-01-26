<?php
/*
  $Id$

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2006 osCommerce

  Released under the GNU General Public License
*/

  class osC_Boxes_information extends osC_Modules {
    var $_title,
        $_code = 'information',
        $_author_name = 'osCommerce',
        $_author_www = 'http://www.oscommerce.com',
        $_group = 'boxes';

    function osC_Boxes_information() {
      global $osC_Language;

      $this->_title = $osC_Language->get('box_information_heading');
      $this->_title_link = tep_href_link(FILENAME_INFO);
    }

    function initialize() {
      global $osC_Language;

      $this->_content = '<a href="' . tep_href_link(FILENAME_INFO, 'shipping') . '">' . $osC_Language->get('box_information_shipping') . '</a><br />' .
                        '<a href="' . tep_href_link(FILENAME_INFO, 'privacy') . '">' . $osC_Language->get('box_information_privacy') . '</a><br />' .
                        '<a href="' . tep_href_link(FILENAME_INFO, 'conditions') . '">' . $osC_Language->get('box_information_conditions') . '</a><br />' .
                        '<a href="' . tep_href_link(FILENAME_INFO, 'contact') . '">' . $osC_Language->get('box_information_contact') . '</a><br />' .
                        '<a href="' . tep_href_link(FILENAME_INFO, 'sitemap') . '">' . $osC_Language->get('box_information_sitemap') . '</a>';
    }
  }
?>
