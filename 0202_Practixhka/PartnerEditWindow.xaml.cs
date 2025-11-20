using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace _0202_Practixhka
{
    /// <summary>
    /// Логика взаимодействия для PartnerEditWindow.xaml
    /// </summary>
    public partial class PartnerEditWindow : Window
    {
        private New_TechnologiesEntities1 db = new New_TechnologiesEntities1();
        private Partner_products_request _currentRequest;
        private bool _isEditMode;

        /// <summary>
        /// конструктор для добавления
        /// </summary>
        
        public PartnerEditWindow()
        {
            InitializeComponent();
            _isEditMode = false;
            LoadFormData();
            Title = "Добавление заявки";
        }

        /// <summary>
        /// конструктор для редактирования
        /// </summary>
        
        public PartnerEditWindow(int requestId)
        {
            InitializeComponent();
            _isEditMode = true;
            LoadFormData();
            LoadRequestData(requestId);
            Title = "Редактирование заявки";
        }
        /// <summary>
        /// загружаем информацию с формы  
        /// </summary>
        private void LoadFormData()
        {
            try
            {
                // загружаем список партнеров
                var partners = db.Partners.ToList();
                cmbPartner.ItemsSource = partners;

                // загружаем список продуктов
                var products = db.Products_import.ToList();
                cmbProduct.ItemsSource = products;

                if (!_isEditMode)
                {
                    if (partners.Any()) cmbPartner.SelectedIndex = 0;
                    if (products.Any()) cmbProduct.SelectedIndex = 0;
                }

                // подписываемся на изменение выбора продукта для расчета стоимости
                cmbProduct.SelectionChanged += CmbProduct_SelectionChanged;
                txtQuantity.TextChanged += TxtQuantity_TextChanged;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке данных: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        /// <summary>
        /// загружаем информацию о заказе
        /// </summary>
        /// <param name="requestId"></param>
        private void LoadRequestData(int requestId)
        {
            try
            {
                _currentRequest = db.Partner_products_request.FirstOrDefault(r => r.ID == requestId);

                if (_currentRequest == null)
                {
                    MessageBox.Show("Заявка не найдена", "Ошибка",
                        MessageBoxButton.OK, MessageBoxImage.Error);
                    this.DialogResult = false;
                    return;
                }

                // заполняем поля данными
                cmbPartner.SelectedValue = _currentRequest.partner;
                cmbProduct.SelectedValue = _currentRequest.prodcut;
                txtQuantity.Text = _currentRequest.product_quantity.ToString();

                UpdateCostInfo();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке данных заявки: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        /// <summary>
        /// обработчик изменения комбобкса с продуктами
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CmbProduct_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateCostInfo();
        }
        /// <summary>
        /// обработчик изменения текстбокса с количеством 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void TxtQuantity_TextChanged(object sender, TextChangedEventArgs e)
        {
            UpdateCostInfo();
        }
        /// <summary>
        /// обновление стоимости и цены
        /// </summary>
        private void UpdateCostInfo()
        {
            try
            {
                if (cmbProduct.SelectedItem is Products_import product &&
                    int.TryParse(txtQuantity.Text, out int quantity) && quantity > 0)
                {
                    double price = product.patner_minimal_price ?? 0;
                    double totalCost = price * quantity;

                    txtPriceInfo.Text = $"Цена: {price:N2} руб. за единицу";
                    txtTotalCost.Text = $"Общая стоимость: {totalCost:N2} руб.";
                }
                else
                {
                    txtPriceInfo.Text = "Цена: 0 руб.";
                    txtTotalCost.Text = "Общая стоимость: 0 руб.";
                }
            }
            catch
            {
                txtPriceInfo.Text = "Цена: 0 руб.";
                txtTotalCost.Text = "Общая стоимость: 0 руб.";
            }
        }

        /// <summary>
        /// валидация числовых полей
        /// </summary>
        
        private void NumberValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            e.Handled = !char.IsDigit(e.Text, 0);
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = false;
            this.Close();
        }
        /// <summary>
        /// сохранение заявки
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                if (!ValidateForm())
                    return;

                int oldPartnerId = 0;
                if (_isEditMode)
                {
                    // cохраняем ID старого партнера перед изменением
                    oldPartnerId = (int)_currentRequest.partner;
                    UpdateRequest();
                }
                else
                {
                    CreateRequest();
                }

                db.SaveChanges();

                // если редактировали и поменяли партнера - сообщаем об этом
                if (_isEditMode && oldPartnerId != (int)cmbPartner.SelectedValue)
                {
                    MessageBox.Show("Заявка перемещена к новому партнеру", "Успех",
                        MessageBoxButton.OK, MessageBoxImage.Information);
                }
                else
                {
                    MessageBox.Show("Заявка успешно сохранена!", "Успех",
                        MessageBoxButton.OK, MessageBoxImage.Information);
                }

                this.DialogResult = true;
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        /// <summary>
        /// метод с валидацией
        /// </summary>
        /// <returns></returns>
        private bool ValidateForm()
        {
            if (cmbPartner.SelectedValue == null)
            {
                MessageBox.Show("Выберите партнера", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            if (cmbProduct.SelectedValue == null)
            {
                MessageBox.Show("Выберите продукт", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            if (!int.TryParse(txtQuantity.Text, out int quantity) || quantity <= 0)
            {
                MessageBox.Show("Введите корректное количество (целое положительное число)", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            return true;
        }
        /// <summary>
        /// обновление щаявки в баще данных
        /// </summary>
        private void UpdateRequest()
        {
            _currentRequest.partner = (int)cmbPartner.SelectedValue;
            _currentRequest.prodcut = (int)cmbProduct.SelectedValue;
            _currentRequest.product_quantity = int.Parse(txtQuantity.Text);
        }
        /// <summary>
        /// создание новой заяки в базе данных
        /// </summary>
        private void CreateRequest()
        {
            var newRequest = new Partner_products_request
            {
                partner = (int)cmbPartner.SelectedValue,
                prodcut = (int)cmbProduct.SelectedValue,
                product_quantity = int.Parse(txtQuantity.Text)
            };

            db.Partner_products_request.Add(newRequest);
        }
    }
}