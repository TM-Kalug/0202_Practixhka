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
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data.Entity;

namespace _0202_Practixhka
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void ShowPartnerRequests_Click(object sender, RoutedEventArgs e)
        {
            Requests r = new Requests();
            r.Show();
            this.Close();
        }

        private void ShowProductsList_Click(object sender, RoutedEventArgs e)
        {
            PartnerMaterialsWindow pmw = new PartnerMaterialsWindow();
            pmw.Show();
            this.Close();
        }

        private void Calculate_Click(object sender, RoutedEventArgs e)
        {
            CalculateWindow cwc = new CalculateWindow();
            cwc.Show();
            this.Close();
        }
    }
}

