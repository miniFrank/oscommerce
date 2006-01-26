<?php
/*
  $Id:account.php 188 2005-09-15 02:25:52 +0200 (Do, 15 Sep 2005) hpdl $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2005 osCommerce

  Released under the GNU General Public License
*/

  require('includes/classes/order.php');

  class osC_Account_Account extends osC_Template {

/* Private variables */

    var $_module = 'account',
        $_group = 'account',
        $_page_title,
        $_page_contents = 'account.php';

    function osC_Account_Account() {
      global $osC_Language;

      $this->_page_title = $osC_Language->get('account_heading');
    }
  }
?>
