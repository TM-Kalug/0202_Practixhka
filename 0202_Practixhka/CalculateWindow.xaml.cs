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
    /// Логика взаимодействия для CalculateWindow.xaml
    /// </summary>
    public partial class CalculateWindow : Window
    {
        private New_TechnologiesEntities1 db = new New_TechnologiesEntities1();

        public CalculateWindow()
        {
            InitializeComponent();
            LoadComboBoxData();
        }
        /// <summary>
        /// Загрузка комбобоксов
        /// </summary>
        private void LoadComboBoxData()
        {
            try
            {
                // Загрузка типов продукции
                var productTypes = db.Product_types.ToList();
                cmbProductType.ItemsSource = productTypes;

                // Загрузка типов материалов
                var materialTypes = db.Material_type.ToList();
                cmbMaterialType.ItemsSource = materialTypes;

                if (productTypes.Any()) cmbProductType.SelectedIndex = 0;
                if (materialTypes.Any()) cmbMaterialType.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при загрузке данных: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        /// <summary>
        /// Обработчик кнопки "Рассчитать"
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CalculateButton_Click(object sender, RoutedEventArgs e)
        {
            if (!ValidateInput())
                return;

            try
            {
                int productTypeId = (int)cmbProductType.SelectedValue;
                int materialTypeId = (int)cmbMaterialType.SelectedValue;
                int requiredQuantity = int.Parse(txtRequiredQuantity.Text);
                int warehouseQuantity = int.Parse(txtWarehouseQuantity.Text);
                double parameter1 = double.Parse(txtParameter1.Text);
                double parameter2 = double.Parse(txtParameter2.Text);

                int result = CalculateMaterialQuantity(
                    productTypeId, materialTypeId, requiredQuantity,
                    warehouseQuantity, parameter1, parameter2);

                if (result == -1)
                {
                    MessageBox.Show("Ошибка расчета. Проверьте введенные данные.",
                        "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                    txtResult.Text = "Результат: -1";
                }
                else
                {
                    txtResult.Text = $"Результат: {result} единиц материала";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при расчете: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        /// <summary>
        /// Метад с рассчетом
        /// </summary>
        /// <param name="productTypeId"></param>
        /// <param name="materialTypeId"></param>
        /// <param name="requiredQuantity"></param>
        /// <param name="warehouseQuantity"></param>
        /// <param name="parameter1"></param>
        /// <param name="parameter2"></param>
        /// <returns></returns>
        private int CalculateMaterialQuantity(int productTypeId, int materialTypeId,
            int requiredQuantity, int warehouseQuantity, double parameter1, double parameter2)
        {
            try
            {
                // проверка существования типов продукции и материалов
                var productType = db.Product_types.FirstOrDefault(pt => pt.ID == productTypeId);
                var materialType = db.Material_type.FirstOrDefault(mt => mt.ID == materialTypeId);

                if (productType == null || materialType == null)
                    return -1;

                // проверка наличия коэффициентов
                if (!productType.product_type_coefficient.HasValue || !materialType.defective_material_percent.HasValue)
                    return -1;

                // валидация входных параметров
                if (requiredQuantity <= 0 || warehouseQuantity < 0 || parameter1 <= 0 || parameter2 <= 0)
                    return -1;

                double productCoefficient = productType.product_type_coefficient.Value;
                double defectPercentage = materialType.defective_material_percent.Value;

                // расчет необходимого количества продукции (минус то, что уже на складе)
                int productionQuantity = Math.Max(0, requiredQuantity - warehouseQuantity);

                // если вся продукция уже на складе, материал не нужен
                if (productionQuantity == 0)
                    return 0;

                // расчет материала на одну единицу продукции
                double materialPerUnit = parameter1 * parameter2 * productCoefficient;

                // учет брака материала (увеличиваем количество материала)
                double materialWithDefect = materialPerUnit * (1 + defectPercentage / 100.0);

                // общее количество материала для всего производства
                double totalMaterial = materialWithDefect * productionQuantity;

                // округление в большую сторону до целого числа
                return (int)Math.Ceiling(totalMaterial);
            }
            catch
            {
                return -1;
            }
        }
        /// <summary>
        /// Метод проверки входных данных
        /// </summary>
        /// <returns></returns>
        private bool ValidateInput()
        {
            // проверка выбора типов
            if (cmbProductType.SelectedValue == null || cmbMaterialType.SelectedValue == null)
            {
                MessageBox.Show("Выберите тип продукции и тип материала",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            // проверка числовых полей
            if (!int.TryParse(txtRequiredQuantity.Text, out int reqQty) || reqQty <= 0)
            {
                MessageBox.Show("Введите корректное требуемое количество (целое положительное число)",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            if (!int.TryParse(txtWarehouseQuantity.Text, out int whQty) || whQty < 0)
            {
                MessageBox.Show("Введите корректное количество на складе (целое неотрицательное число)",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            if (!double.TryParse(txtParameter1.Text, out double param1) || param1 <= 0)
            {
                MessageBox.Show("Введите корректное значение параметра 1 (положительное число)",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            if (!double.TryParse(txtParameter2.Text, out double param2) || param2 <= 0)
            {
                MessageBox.Show("Введите корректное значение параметра 2 (положительное число)",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return false;
            }

            return true;
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mw = new MainWindow();
            mw.Show();
            this.Close();
        }

        private void ClearButton_Click(object sender, RoutedEventArgs e)
        {
            txtRequiredQuantity.Clear();
            txtWarehouseQuantity.Clear();
            txtParameter1.Clear();
            txtParameter2.Clear();
            txtResult.Text = "Результат: ";
        }
        /// <summary>
        /// Обработчик тестбокса с входными данными int  
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void IntValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            e.Handled = !char.IsDigit(e.Text, 0);
        }
        /// <summary>
        /// Обработчик текстбокса с входными данными double
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void DoubleValidationTextBox(object sender, TextCompositionEventArgs e)
        {
            e.Handled = !(char.IsDigit(e.Text, 0) || e.Text == "," || e.Text == ".");
        }
    }
}
