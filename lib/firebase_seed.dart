import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadData() async {
  final firestore = FirebaseFirestore.instance;
  try {
    await firestore.collection('products').doc('iphone').set({
      'name': 'iPhone',
      'producer': 'Apple',
      'models': [
        {
          'modelname': 'iPhone 12',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 699,
              'averagerating': 4.6,
              'reviews': [
                'Good budget iPhone with solid performance.',
                'The camera is good for the price.',
                'Value for money is excellent.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 509,
              'averagerating': 4.7,
              'reviews': [
                'Great value for a budget phone.',
                'Fast shipping and reliable service.',
                'Performance is impressive for the price.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 499,
              'averagerating': 4.5,
              'reviews': [
                'Affordable with good performance.',
                'The camera and features are decent.',
                'A good choice for those on a budget.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 499,
              'averagerating': 4.6,
              'reviews': [
                'Good performance at a budget price.',
                'Costco return policy is a plus.',
                'Very good value for money.'
              ]
            },
            {
              'sellername': 'The Source',
              'price': 519,
              'averagerating': 4.4,
              'reviews': [
                'Good budget option with decent features.',
                'Slightly higher price but good service.',
                'Satisfactory overall experience.'
              ]
            }
          ],
          'reviews': [
            'Affordable iPhone with solid features.',
            'Good performance and value.',
            'A great choice for those looking for a budget phone.'
          ]
        },
        {
          'modelname': 'iPhone 13',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 999,
              'averagerating': 4.8,
              'reviews': [
                'Amazing camera and performance.',
                'The ProMotion display is fantastic.',
                'A bit expensive but worth every penny.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 949,
              'averagerating': 4.7,
              'reviews': [
                'Excellent performance and display.',
                'Battery life is impressive.',
                'The price is high but justified.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 979,
              'averagerating': 4.6,
              'reviews': [
                'Great phone with superb features.',
                'The price is competitive for the specs.',
                'Highly recommended.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 949,
              'averagerating': 4.7,
              'reviews': [
                'Fantastic phone with great performance.',
                'Costco warranty is a plus.',
                'Excellent value for the price.'
              ]
            }
          ],
          'reviews': [
            'Top-notch performance and camera.',
            'ProMotion display is a game changer.',
            'High price but very high quality.'
          ]
        },
        {
          'modelname': 'iPhone 14',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 429,
              'averagerating': 4.5,
              'reviews': [
                'Great performance for the price.',
                'Compact design with modern specs.',
                'A good budget-friendly option.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 399,
              'averagerating': 4.6,
              'reviews': [
                'Excellent performance in a small package.',
                'Good value for the price.',
                'Battery life could be better.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 419,
              'averagerating': 4.4,
              'reviews': [
                'Affordable and powerful.',
                'Great for those who prefer smaller phones.',
                'Performance is impressive for the price.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 399,
              'averagerating': 4.5,
              'reviews': [
                'Value for money is excellent.',
                'Compact with good performance.',
                'Highly recommended for budget-conscious buyers.'
              ]
            }
          ],
          'reviews': [
            'Affordable with good performance.',
            'Compact size and powerful specs.',
            'Great choice for budget buyers.'
          ]
        },
        {
          'modelname': 'iPhone 15',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 699,
              'averagerating': 4.5,
              'reviews': [
                'Compact and powerful.',
                'The size is perfect for small hands.',
                'Good value for the price.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 669,
              'averagerating': 4.6,
              'reviews': [
                'Great for those who want a smaller phone.',
                'Performance is solid for its size.',
                'Price is reasonable for its features.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 699,
              'averagerating': 4.4,
              'reviews': [
                'Compact design with good performance.',
                'The camera quality is impressive.',
                'A bit pricey but worth it.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 679,
              'averagerating': 4.5,
              'reviews': [
                'Good performance and compact size.',
                'Costco warranty is a bonus.',
                'A great choice for those preferring smaller phones.'
              ]
            }
          ],
          'reviews': [
            'Compact with impressive performance.',
            'Great for users who prefer smaller devices.',
            'Good value for the price.'
          ]
        }
      ]
    });

    await firestore.collection('products').doc('monitor').set({
      'name': 'Monitor',
      'producer': 'Samsung',
      'models': [
        {
          'modelname': 'Curved Monitor 24"',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 199,
              'averagerating': 4.5,
              'reviews': [
                'Curved screen is very effective.',
                'Good build quality and performance.',
                'The price is a bit high.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 189,
              'averagerating': 4.4,
              'reviews': [
                'Great monitor for gaming.',
                'Curved screen enhances the experience.',
                'The price is reasonable.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 179,
              'averagerating': 4.3,
              'reviews': [
                'Good value for the price.',
                'Curved screen provides a better viewing experience.',
                'The quality is decent.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 199,
              'averagerating': 4.6,
              'reviews': [
                'Excellent performance and value.',
                'Highly recommended.'
              ]
            },
            {
              'sellername': 'The Source',
              'price': 189,
              'averagerating': 4.4,
              'reviews': [
                'Good quality for the price.',
                'Curved screen is a nice feature.',
                'Satisfactory purchase overall.'
              ]
            }
          ],
          'reviews': [
            'Curved monitor provides a better viewing experience.',
            'Good quality and performance.',
            'The price is reasonable for the features.'
          ]
        },
        {
          'modelname': '4K Monitor 27"',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 399,
              'averagerating': 4.7,
              'reviews': [
                'Exceptional 4K display.',
                'High-quality build and performance.',
                'A bit pricey but worth it.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 379,
              'averagerating': 4.6,
              'reviews': [
                'Fantastic 4K monitor with excellent clarity.',
                'Enhances productivity and gaming experience.',
                'Price is justified by the quality.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 359,
              'averagerating': 4.5,
              'reviews': [
                'Great resolution and display quality.',
                'Good value for the price.',
                'The price is competitive.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 399,
              'averagerating': 4.8,
              'reviews': [
                'Top-notch 4K display.',
                'Excellent for both work and gaming.'
              ]
            }
          ],
          'reviews': [
            'Superb 4K resolution and clarity.',
            'Excellent build quality and performance.',
            'Highly recommended for high-resolution needs.'
          ]
        },
        {
          'modelname': 'Ultrawide Monitor 34"',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 549,
              'averagerating': 4.6,
              'reviews': [
                'Wide screen enhances productivity.',
                'Excellent build quality.',
                'A bit expensive but worth it.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 529,
              'averagerating': 4.5,
              'reviews': [
                'Fantastic ultrawide screen for multitasking.',
                'Good performance and clarity.',
                'Price is reasonable for the size.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 509,
              'averagerating': 4.4,
              'reviews': [
                'Great for work and gaming.',
                'Wide screen is very immersive.',
                'The price is competitive.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 549,
              'averagerating': 4.7,
              'reviews': [
                'Excellent ultrawide monitor.',
                'Highly recommended for professionals.'
              ]
            }
          ],
          'reviews': [
            'Ultrawide monitor is excellent for multitasking.',
            'High-quality build and performance.',
            'The price reflects the quality.'
          ]
        },
        {
          'modelname': 'Gaming Monitor 27"',
          'sellers': [
            {
              'sellername': 'Best Buy',
              'price': 299,
              'averagerating': 4.8,
              'reviews': [
                'Great for gaming with high refresh rate.',
                'Excellent color accuracy and performance.',
                'Price is justified by the features.'
              ]
            },
            {
              'sellername': 'Amazon',
              'price': 279,
              'averagerating': 4.7,
              'reviews': [
                'Fantastic monitor for gaming.',
                'Good refresh rate and color accuracy.',
                'Value for money is high.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 259,
              'averagerating': 4.6,
              'reviews': [
                'Good for fast-paced gaming.',
                'High refresh rate and good quality.',
                'The price is reasonable.'
              ]
            },
            {
              'sellername': 'Costco',
              'price': 299,
              'averagerating': 4.8,
              'reviews': [
                'Excellent gaming monitor.',
                'Highly recommended for gamers.'
              ]
            }
          ],
          'reviews': [
            'Excellent for gaming with high refresh rate.',
            'Good build quality and color accuracy.',
            'The price is reasonable for the features.'
          ]
        }
      ]
    });

    await firestore.collection('products').doc('shampoo').set({
      'name': 'Shampoo',
      'producer': 'Dove',
      'models': [
        {
          'modelname': 'Dove Nourishing Secrets',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 8,
              'averagerating': 4.6,
              'reviews': [
                'Leaves hair soft and manageable.',
                'The scent is pleasant.',
                'Good for daily use.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 7,
              'averagerating': 4.5,
              'reviews': [
                'Effective conditioning properties.',
                'The scent is nice.',
                'Good value for money.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Pleasant scent and good conditioning.',
                'Good for daily use.',
                'Value for money is excellent.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 8,
              'averagerating': 4.6,
              'reviews': [
                'Leaves hair smooth and manageable.',
                'The scent is refreshing.',
                'Good quality for the price.'
              ]
            }
          ],
          'reviews': [
            'Good for daily use.',
            'Effective conditioning properties.',
            'Pleasant scent and value for money.'
          ]
        },
        {
          'modelname': 'Dove Deep Moisture',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 9,
              'averagerating': 4.7,
              'reviews': [
                'Excellent moisture for dry hair.',
                'The scent is very pleasant.',
                'The price is reasonable for the quality.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 8.5,
              'averagerating': 4.6,
              'reviews': [
                'Good hydration and conditioning.',
                'Pleasant scent and good value.',
                'Effective for dry hair.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 8.5,
              'averagerating': 4.5,
              'reviews': [
                'Keeps hair moisturized and soft.',
                'The scent is nice.',
                'Satisfactory conditioning properties.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 9,
              'averagerating': 4.6,
              'reviews': [
                'Effective for moisturizing.',
                'Pleasant scent and good value.',
                'Satisfactory overall experience.'
              ]
            }
          ],
          'reviews': [
            'Excellent for dry hair.',
            'Good moisture and conditioning.',
            'Pleasant scent and effective.'
          ]
        },
        {
          'modelname': 'Dove Refreshing Care',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Refreshing and revitalizing.',
                'The scent is invigorating.',
                'Good value for the price.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 7,
              'averagerating': 4.3,
              'reviews': [
                'Keeps hair feeling fresh.',
                'Pleasant scent and good performance.',
                'A bit of a strong fragrance.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Refreshing and good for everyday use.',
                'The scent is nice.',
                'Effective and affordable.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 7.5,
              'averagerating': 4.5,
              'reviews': [
                'Keeps hair fresh and clean.',
                'Pleasant scent.',
                'Good overall performance.'
              ]
            }
          ],
          'reviews': [
            'Refreshing and revitalizing.',
            'Pleasant scent and effective.',
            'Good for everyday use.'
          ]
        },
        {
          'modelname': 'Dove Volume Boost',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 8,
              'averagerating': 4.5,
              'reviews': [
                'Adds volume and body to hair.',
                'The scent is pleasant.',
                'Good for fine hair.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Effective at boosting volume.',
                'Pleasant scent.',
                'Good value for money.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 8,
              'averagerating': 4.3,
              'reviews': [
                'Adds volume and texture.',
                'The scent is nice.',
                'Decent performance overall.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 8,
              'averagerating': 4.4,
              'reviews': [
                'Good volume and body.',
                'Pleasant scent.',
                'Satisfactory overall performance.'
              ]
            }
          ],
          'reviews': [
            'Adds volume and body to hair.',
            'Pleasant scent and effective.',
            'Good for fine hair.'
          ]
        }
      ]
    });

    await firestore.collection('products').doc('conditioner').set({
      'name': 'Conditioner',
      'producer': 'Dove',
      'models': [
        {
          'modelname': 'Dove Nourishing Conditioner',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 8,
              'averagerating': 4.6,
              'reviews': [
                'Leaves hair soft and smooth.',
                'The scent is pleasant.',
                'Good for daily use.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 7.5,
              'averagerating': 4.5,
              'reviews': [
                'Effective conditioning properties.',
                'The scent is nice.',
                'Good value for money.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Pleasant scent and good conditioning.',
                'Good for daily use.',
                'Value for money is excellent.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 8,
              'averagerating': 4.6,
              'reviews': [
                'Leaves hair smooth and manageable.',
                'The scent is refreshing.',
                'Good quality for the price.'
              ]
            }
          ],
          'reviews': [
            'Good for daily use.',
            'Effective conditioning properties.',
            'Pleasant scent and value for money.'
          ]
        },
        {
          'modelname': 'Dove Deep Moisture Conditioner',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 9,
              'averagerating': 4.7,
              'reviews': [
                'Excellent moisture for dry hair.',
                'The scent is very pleasant.',
                'The price is reasonable for the quality.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 8.5,
              'averagerating': 4.6,
              'reviews': [
                'Good hydration and conditioning.',
                'Pleasant scent and good value.',
                'Effective for dry hair.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 8.5,
              'averagerating': 4.5,
              'reviews': [
                'Keeps hair moisturized and soft.',
                'The scent is nice.',
                'Satisfactory conditioning properties.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 9,
              'averagerating': 4.6,
              'reviews': [
                'Effective for moisturizing.',
                'Pleasant scent and good value.',
                'Satisfactory overall experience.'
              ]
            }
          ],
          'reviews': [
            'Excellent for dry hair.',
            'Good moisture and conditioning.',
            'Pleasant scent and effective.'
          ]
        },
        {
          'modelname': 'Dove Refreshing Conditioner',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Refreshing and revitalizing.',
                'The scent is invigorating.',
                'Good value for the price.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 7,
              'averagerating': 4.3,
              'reviews': [
                'Keeps hair feeling fresh.',
                'Pleasant scent and good performance.',
                'A bit of a strong fragrance.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Refreshing and good for everyday use.',
                'The scent is nice.',
                'Effective and affordable.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 7.5,
              'averagerating': 4.5,
              'reviews': [
                'Keeps hair fresh and clean.',
                'Pleasant scent.',
                'Good overall performance.'
              ]
            }
          ],
          'reviews': [
            'Refreshing and revitalizing.',
            'Pleasant scent and effective.',
            'Good for everyday use.'
          ]
        },
        {
          'modelname': 'Dove Volume Boost Conditioner',
          'sellers': [
            {
              'sellername': 'Amazon',
              'price': 8,
              'averagerating': 4.5,
              'reviews': [
                'Adds volume and body to hair.',
                'The scent is pleasant.',
                'Good for fine hair.'
              ]
            },
            {
              'sellername': 'Walmart',
              'price': 7.5,
              'averagerating': 4.4,
              'reviews': [
                'Effective at boosting volume.',
                'Pleasant scent.',
                'Good value for money.'
              ]
            },
            {
              'sellername': 'Shoppers Drug Mart',
              'price': 8,
              'averagerating': 4.3,
              'reviews': [
                'Adds volume and texture.',
                'The scent is nice.',
                'Decent performance overall.'
              ]
            },
            {
              'sellername': 'Loblaws',
              'price': 8,
              'averagerating': 4.4,
              'reviews': [
                'Good volume and body.',
                'Pleasant scent.',
                'Satisfactory overall performance.'
              ]
            }
          ],
          'reviews': [
            'Adds volume and body to hair.',
            'Pleasant scent and effective.',
            'Good for fine hair.'
          ]
        }
      ]
    });

    print("Data uploaded successfully!");
  } catch (e) {
    print("Error uploading data: $e");
  }
}
