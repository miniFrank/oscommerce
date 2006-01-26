<?php
/*
  $Id:shopping_cart.php 187 2005-09-14 14:22:13 +0200 (Mi, 14 Sep 2005) hpdl $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2005 osCommerce

  Released under the GNU General Public License
*/
?>

<?php echo tep_image(DIR_WS_IMAGES . 'table_background_cart.gif', $osC_Template->getPageTitle(), HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT, 'class="pageIcon"'); ?>

<h1><?php echo $osC_Template->getPageTitle(); ?></h1>

<?php
  if ($_SESSION['cart']->count_contents() > 0) {
?>

<form name="shopping_cart" action="<?php echo tep_href_link(FILENAME_CHECKOUT, 'action=update_product', 'SSL'); ?>" method="post">

<div class="moduleBox">
  <div class="outsideHeading"><?php echo $osC_Language->get('shopping_cart_heading'); ?></div>

  <div class="content">
    <table border="0" width="100%" cellspacing="0" cellpadding="2">

<?php
    $_cart_date_added = null;
    foreach ($osC_Template->getListing() as $products) {
      if (osC_DateTime::getShort($products['date_added']) != $_cart_date_added) {
        $_cart_date_added = osC_DateTime::getShort($products['date_added']);
?>

      <tr>
        <td colspan="4"><?php echo sprintf($osC_Language->get('date_added_to_shopping_cart'), osC_DateTime::getShort($products['date_added'])); ?></td>
      </tr>

<?php
      }
?>

      <tr>
        <td valign="top" width="60"><?php echo '<a href="' . tep_href_link(FILENAME_CHECKOUT, 'action=cartRemove&amp;products_id=' . $products['id'], 'SSL') . '">' . tep_image_button('small_delete.gif', $osC_Language->get('button_delete')) . '</a>'; ?></td>
        <td valign="top">

<?php
      echo '<a href="' . tep_href_link(FILENAME_PRODUCTS, $products['id']) . '"><b>' . $products['name'] . '</b></a>';

      if ( (STOCK_CHECK == 'true') && ($osC_Template->hasStock($products['id'], $products['quantity']) === false) ) {
        echo '<span class="markProductOutOfStock">' . STOCK_MARK_PRODUCT_OUT_OF_STOCK . '</span>';
      }

      echo '&nbsp;(Top Category)';

      if ($osC_Template->hasAttributes($products['id'])) {
        foreach ($osC_Template->getAttributes($products['id']) as $attributes) {
          echo osc_draw_hidden_field('id[' . $products['id'] . '][' . $attributes['options_id'] . ']', $attributes['options_values_id']);

          echo '<br />- ' . $attributes['products_options_name'] . ': ' . $attributes['products_options_values_name'];
        }
      }
?>

        </td>
        <td valign="top"><?php echo osc_draw_input_field('cart_quantity[]', $products['quantity'], 'size="4"') . osc_draw_hidden_field('products_id[]', $products['id']); ?></td>
        <td valign="top" align="right"><?php echo '<b>' . $osC_Currencies->displayPrice($products['final_price'], $products['tax_class_id'], $products['quantity']) . '</b>'; ?></td>
      </tr>

<?php
    }
?>

    </table>
  </div>

  <p style="text-align: right; padding-right: 7px;"><b><?php echo $osC_Language->get('subtotal_title'); ?> <?php echo $osC_Currencies->format($_SESSION['cart']->show_total()); ?></b></p>

<?php
    if ( (STOCK_CHECK == 'true') && ($osC_Template->hasProductsOutOfStock() === true) ) {
      if (STOCK_ALLOW_CHECKOUT == 'true') {
        echo '<p class="stockWarning" align="center">' . sprintf($osC_Language->get('products_out_of_stock_checkout_possible'), STOCK_MARK_PRODUCT_OUT_OF_STOCK) . '</p>';
      } else {
        echo '<p class="stockWarning" align="center">' . sprintf($osC_Language->get('products_out_of_stock_checkout_not_possible'), STOCK_MARK_PRODUCT_OUT_OF_STOCK) . '</p>';
      }
    }
?>

</div>

<div class="submitFormButtons">
  <span style="float: right;"><?php echo '<a href="' . tep_href_link(FILENAME_CHECKOUT, 'shipping', 'SSL') . '">' . tep_image_button('button_checkout.gif', $osC_Language->get('button_checkout')) . '</a>'; ?></span>

  <?php echo tep_image_submit('button_update_cart.gif', $osC_Language->get('button_update_cart')); ?>
</div>

</form>

<?php
  } else {
?>

<div class="moduleBox">
  <div class="content">
    <?php echo $osC_Language->get('shopping_cart_empty'); ?>
  </div>
</div>

<div class="submitFormButtons">
  <span style="float: right;"><?php echo '<a href="' . tep_href_link(FILENAME_DEFAULT) . '">' . tep_image_button('button_continue.gif', $osC_Language->get('button_continue')) . '</a>'; ?></span>
</div>

<?php
  }
?>
