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
using System.Data.Entity;

namespace _0202_Practixhka
{
    /// <summary>
    /// Логика взаимодействия для Requests.xaml
    /// </summary>
    public partial class Requests : Window
    {
        New_TechnologiesEntities1 db = new New_TechnologiesEntities1();
        public Requests()
        {
            InitializeComponent();
            LoadPartnersRequest();
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            this.Close();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void AddRequest_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                // Открываем форму добавления/редактирования в режиме добавления
                PartnerEditWindow editWindow = new PartnerEditWindow();
                if (editWindow.ShowDialog() == true)
                {
                    // Обновляем список после добавления
                    LoadPartnersRequest();
                }
            }
            catch (Exception ex)
            {
                ShowError("Ошибка при открытии формы добавления", ex);
            }
        }
        /// <summary>
        /// Редактирование при двойном клике
        /// </summary>
        private void ListRequests_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            try
            {
                
                if (listRequests.SelectedItem is Border border && border.Tag is int requestId)
                {
                    PartnerEditWindow editWindow = new PartnerEditWindow(requestId);
                    if (editWindow.ShowDialog() == true)
                    {
                        LoadPartnersRequest();
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Ошибка при открытии формы редактирования", ex);
            }
        }
        /// <summary>
        /// загрузить спсок заказов партнеров 
        /// </summary>
        private void LoadPartnersRequest()
        {
            listRequests.Items.Clear();
            listRequestsCanvas.Visibility = Visibility.Visible;

            try
            {
                // группируем заявки по партнеру и рассчитываем общую стоимость
                var partnerRequests = db.Partner_products_request
                    .Include(ppr => ppr.Partner1)
                    .Include(ppr => ppr.Products_import)
                    .GroupBy(ppr => ppr.partner)
                    .Select(g => new
                    {
                        PartnerId = g.Key,
                        Partner = g.FirstOrDefault().Partner1, // берем данные партнера
                PartnerType = g.FirstOrDefault().Partner1.Partners_types, // тип партнера
                TotalCost = g.Sum(ppr => ppr.product_quantity * ppr.Products_import.patner_minimal_price),
                        RequestIds = g.Select(ppr => ppr.ID).ToList() // сохраняем ID заявок для редактирования
            })
                    .ToList();

                foreach (var request in partnerRequests)
                {
                    if (request.Partner != null)
                    {
                        decimal totalCost = Math.Round((decimal)request.TotalCost, 2);
                        if (totalCost < 0) totalCost = 0;

                        // передаем первый ID заявки для редактирования (можно выбрать любой)
                        CreateRequestItem(request.Partner, request.PartnerType, totalCost, request.RequestIds.FirstOrDefault());
                    }
                }

            }
            catch (Exception ex)
            {
                ShowError("Ошибка при загрузке заявок", ex);
            }
        }
        /// <summary>
        /// создание блока 
        /// </summary>
        /// <param name="partner"></param>
        /// <param name="partnerType"></param>
        /// <param name="totalCost"></param>
        /// <param name="requestId"></param>
        private void CreateRequestItem(Partner partner, Partners_types partnerType, decimal totalCost, int requestId)
        {
            Border border = new Border();
            border.Tag = requestId;
            border.Width = 1120;
            border.Height = 110;
            border.Background = Brushes.White;
            border.BorderBrush = Brushes.LightGray;
            border.BorderThickness = new Thickness(1);
            border.Margin = new Thickness(10, 5, 10, 5);
            border.CornerRadius = new CornerRadius(5); // сохраняем ID для редактирования

            Grid grid = new Grid();
            grid.Width = 1100;
            grid.Height = 100;

            grid.ColumnDefinitions.Add(new ColumnDefinition() { Width = new GridLength(1, GridUnitType.Star) });
            grid.ColumnDefinitions.Add(new ColumnDefinition() { Width = GridLength.Auto });

            grid.RowDefinitions.Add(new RowDefinition() { Height = new GridLength(30, GridUnitType.Pixel) });
            grid.RowDefinitions.Add(new RowDefinition() { Height = new GridLength(25, GridUnitType.Pixel) });
            grid.RowDefinitions.Add(new RowDefinition() { Height = new GridLength(25, GridUnitType.Pixel) });
            grid.RowDefinitions.Add(new RowDefinition() { Height = new GridLength(20, GridUnitType.Pixel) });

            TextBlock typeNameBlock = new TextBlock();
            typeNameBlock.Text = $"{partnerType?.name ?? "Не указан"} | {partner.partner_name}";
            typeNameBlock.FontSize = 16;
            typeNameBlock.FontWeight = FontWeights.Bold;
            typeNameBlock.VerticalAlignment = VerticalAlignment.Center;
            typeNameBlock.Margin = new Thickness(15, 0, 0, 0);
            Grid.SetColumn(typeNameBlock, 0);
            Grid.SetRow(typeNameBlock, 0);

            TextBlock addressBlock = new TextBlock();
            addressBlock.Text = partner.partner_adress ?? "Адрес не указан";
            addressBlock.FontSize = 12;
            addressBlock.VerticalAlignment = VerticalAlignment.Center;
            addressBlock.Margin = new Thickness(15, 0, 0, 0);
            Grid.SetColumn(addressBlock, 0);
            Grid.SetRow(addressBlock, 1);

            TextBlock phoneBlock = new TextBlock();
            phoneBlock.Text = partner.phone ?? "Телефон не указан";
            phoneBlock.FontSize = 12;
            phoneBlock.VerticalAlignment = VerticalAlignment.Center;
            phoneBlock.Margin = new Thickness(15, 0, 0, 0);
            Grid.SetColumn(phoneBlock, 0);
            Grid.SetRow(phoneBlock, 2);

            TextBlock ratingBlock = new TextBlock();
            ratingBlock.Text = $"Рейтинг: {partner.rating ?? 0}";
            ratingBlock.FontSize = 12;
            ratingBlock.VerticalAlignment = VerticalAlignment.Center;
            ratingBlock.Margin = new Thickness(15, 0, 0, 0);
            Grid.SetColumn(ratingBlock, 0);
            Grid.SetRow(ratingBlock, 3);

            TextBlock costBlock = new TextBlock();
            costBlock.Text = $"{totalCost:N2} руб.";
            costBlock.FontSize = 16;
            costBlock.FontWeight = FontWeights.Bold;
            costBlock.VerticalAlignment = VerticalAlignment.Center;
            costBlock.HorizontalAlignment = HorizontalAlignment.Right;
            costBlock.Margin = new Thickness(0, 0, 20, 0);
            Grid.SetColumn(costBlock, 1);
            Grid.SetRowSpan(costBlock, 4);

            grid.Children.Add(typeNameBlock);
            grid.Children.Add(addressBlock);
            grid.Children.Add(phoneBlock);
            grid.Children.Add(ratingBlock);
            grid.Children.Add(costBlock);

            border.Child = grid;
            listRequests.Items.Add(border);
        }
        /// <summary>
        /// метод для показывания ошибки, чтобы не было дублирования код
        /// </summary>
        /// <param name="message"></param>
        /// <param name="ex"></param>
        private void ShowError(string message, Exception ex)
        {
            MessageBox.Show($"{message}: {ex.Message}", "Ошибка",
                MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }
}