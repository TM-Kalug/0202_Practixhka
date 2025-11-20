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
    /// Логика взаимодействия для PartnerMaterialsWindow.xaml
    /// </summary>
    public partial class PartnerMaterialsWindow : Window
    {
        private New_TechnologiesEntities1 db = new New_TechnologiesEntities1();

        public PartnerMaterialsWindow()
        {
            InitializeComponent();
            LoadMaterials();
        }

        private void LoadMaterials()
        {
            var products = db.Products_import.ToList();
            produsctsGrid.ItemsSource = products;
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mw = new MainWindow();
            mw.Show();
            this.Close();
        }

        private void RefreshButton_Click(object sender, RoutedEventArgs e)
        {
            LoadMaterials();
        }
    }
}
