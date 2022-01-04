{
  "nbformat": 4,
  "nbformat_minor": 0,
  "metadata": {
    "colab": {
      "name": "Week7Scraper.py",
      "provenance": [],
      "collapsed_sections": [],
      "authorship_tag": "ABX9TyPkvvaD3JlwRLlBQf0W6lhb",
      "include_colab_link": true
    },
    "kernelspec": {
      "name": "python3",
      "display_name": "Python 3"
    },
    "language_info": {
      "name": "python"
    }
  },
  "cells": [
    {
      "cell_type": "markdown",
      "metadata": {
        "id": "view-in-github",
        "colab_type": "text"
      },
      "source": [
        "<a href=\"https://colab.research.google.com/github/HenryWRobinson/HenryWRobinson.github.io/blob/main/Week7/Scraper.py\" target=\"_parent\"><img src=\"https://colab.research.google.com/assets/colab-badge.svg\" alt=\"Open In Colab\"/></a>"
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "import requests\n",
        "import pandas as pd\n",
        "import os\n",
        "import numpy as np\n",
        "import string\n",
        "from bs4 import BeautifulSoup"
      ],
      "metadata": {
        "id": "IaKMelhiSNK2"
      },
      "execution_count": 1,
      "outputs": []
    },
    {
      "cell_type": "code",
      "source": [
        "url = \"https://www.national-lottery.co.uk/results/lotto/draw-history\"\n",
        "html = requests.get(url)\n",
        "soup = BeautifulSoup(html.content, 'html.parser')\n",
        "date = soup.find_all(\"li\", class_=\"table_cell table_cell_1 table_cell_1_width_no_raffle table_cell_first\")\n",
        "date_list1=[i.text.replace(\" \",\"\").replace(\"Date\",\"\").replace(\"\\n\",\"\").replace(\"Sat\",\"\").replace(\"Wed\",\"\") for i in date]\n",
        "date_list2=date_list1[1:]\n",
        "print(date_list2)\n",
        "pot = soup.find_all('li',class_='table_cell table_cell_2 table_cell_2_width_no_raffle')\n",
        "pot_list1=[i.text.replace(\" \",\"\").replace(\"Jackpot\",\"\").replace(\"\\n\",\"\").replace(\"£\",\"\").replace(\",\",\"\") for i in pot]\n",
        "pot_list2=pot_list1[1:]\n",
        "print(pot_list2)\n",
        "                            "
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/"
        },
        "id": "5VkE4tLZAXrD",
        "outputId": "e9c0bf06-596c-441a-aca7-985aa5f3b034"
      },
      "execution_count": 2,
      "outputs": [
        {
          "output_type": "stream",
          "name": "stdout",
          "text": [
            "['01Jan2022', '29Dec2021', '25Dec2021', '22Dec2021', '18Dec2021', '15Dec2021', '11Dec2021', '08Dec2021', '04Dec2021', '01Dec2021', '27Nov2021', '24Nov2021', '20Nov2021', '17Nov2021', '13Nov2021', '10Nov2021', '06Nov2021', '03Nov2021', '30Oct2021', '27Oct2021', '23Oct2021', '20Oct2021', '16Oct2021', '13Oct2021', '09Oct2021', '06Oct2021', '02Oct2021', '29Sep2021', '25Sep2021', '22Sep2021', '18Sep2021', '15Sep2021', '11Sep2021', '08Sep2021', '04Sep2021', '01Sep2021', '28Aug2021', '25Aug2021', '21Aug2021', '18Aug2021', '14Aug2021', '11Aug2021', '07Aug2021', '04Aug2021', '31Jul2021', '28Jul2021', '24Jul2021', '21Jul2021', '17Jul2021', '14Jul2021', '10Jul2021']\n",
            "['4201355', '2000000', '15000000', '5472566', '4082078', '2000000', '11704275', '9035615', '7547238', '5364290', '4015362', '2000000', '4026102', '2000000', '4101869', '2000000', '20000000', '2000000', '11042269', '8714754', '7265148', '5107865', '3800000', '2000000', '11836281', '9052462', '7569060', '5370436', '4048514', '2000000', '15000000', '5383627', '4079277', '2000000', '20000000', '9079487', '7596828', '5419064', '4061448', '2000000', '11165532', '8817804', '7357979', '5158495', '3800000', '5162779', '3800000', '2000000', '20000000', '5143792', '3800000']\n"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "df = pd.DataFrame(list(zip(date_list2, pot_list2)))\n",
        "df.columns = ['Date', 'Jackpot(£)']\n",
        "df"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 1000
        },
        "id": "szEVW-XpepNx",
        "outputId": "b19cb06f-44f9-4e89-f2ce-64cc80ff827f"
      },
      "execution_count": 7,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "text/html": [
              "\n",
              "  <div id=\"df-cc5eaaf8-b2eb-4be8-b3ea-bf197a85a030\">\n",
              "    <div class=\"colab-df-container\">\n",
              "      <div>\n",
              "<style scoped>\n",
              "    .dataframe tbody tr th:only-of-type {\n",
              "        vertical-align: middle;\n",
              "    }\n",
              "\n",
              "    .dataframe tbody tr th {\n",
              "        vertical-align: top;\n",
              "    }\n",
              "\n",
              "    .dataframe thead th {\n",
              "        text-align: right;\n",
              "    }\n",
              "</style>\n",
              "<table border=\"1\" class=\"dataframe\">\n",
              "  <thead>\n",
              "    <tr style=\"text-align: right;\">\n",
              "      <th></th>\n",
              "      <th>Date</th>\n",
              "      <th>Jackpot(£)</th>\n",
              "    </tr>\n",
              "  </thead>\n",
              "  <tbody>\n",
              "    <tr>\n",
              "      <th>0</th>\n",
              "      <td>01Jan2022</td>\n",
              "      <td>4201355</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>1</th>\n",
              "      <td>29Dec2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>2</th>\n",
              "      <td>25Dec2021</td>\n",
              "      <td>15000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>3</th>\n",
              "      <td>22Dec2021</td>\n",
              "      <td>5472566</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>4</th>\n",
              "      <td>18Dec2021</td>\n",
              "      <td>4082078</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>5</th>\n",
              "      <td>15Dec2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>6</th>\n",
              "      <td>11Dec2021</td>\n",
              "      <td>11704275</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>7</th>\n",
              "      <td>08Dec2021</td>\n",
              "      <td>9035615</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>8</th>\n",
              "      <td>04Dec2021</td>\n",
              "      <td>7547238</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>9</th>\n",
              "      <td>01Dec2021</td>\n",
              "      <td>5364290</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>10</th>\n",
              "      <td>27Nov2021</td>\n",
              "      <td>4015362</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>11</th>\n",
              "      <td>24Nov2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>12</th>\n",
              "      <td>20Nov2021</td>\n",
              "      <td>4026102</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>13</th>\n",
              "      <td>17Nov2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>14</th>\n",
              "      <td>13Nov2021</td>\n",
              "      <td>4101869</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>15</th>\n",
              "      <td>10Nov2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>16</th>\n",
              "      <td>06Nov2021</td>\n",
              "      <td>20000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>17</th>\n",
              "      <td>03Nov2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>18</th>\n",
              "      <td>30Oct2021</td>\n",
              "      <td>11042269</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>19</th>\n",
              "      <td>27Oct2021</td>\n",
              "      <td>8714754</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>20</th>\n",
              "      <td>23Oct2021</td>\n",
              "      <td>7265148</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>21</th>\n",
              "      <td>20Oct2021</td>\n",
              "      <td>5107865</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>22</th>\n",
              "      <td>16Oct2021</td>\n",
              "      <td>3800000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>23</th>\n",
              "      <td>13Oct2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>24</th>\n",
              "      <td>09Oct2021</td>\n",
              "      <td>11836281</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>25</th>\n",
              "      <td>06Oct2021</td>\n",
              "      <td>9052462</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>26</th>\n",
              "      <td>02Oct2021</td>\n",
              "      <td>7569060</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>27</th>\n",
              "      <td>29Sep2021</td>\n",
              "      <td>5370436</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>28</th>\n",
              "      <td>25Sep2021</td>\n",
              "      <td>4048514</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>29</th>\n",
              "      <td>22Sep2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>30</th>\n",
              "      <td>18Sep2021</td>\n",
              "      <td>15000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>31</th>\n",
              "      <td>15Sep2021</td>\n",
              "      <td>5383627</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>32</th>\n",
              "      <td>11Sep2021</td>\n",
              "      <td>4079277</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>33</th>\n",
              "      <td>08Sep2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>34</th>\n",
              "      <td>04Sep2021</td>\n",
              "      <td>20000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>35</th>\n",
              "      <td>01Sep2021</td>\n",
              "      <td>9079487</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>36</th>\n",
              "      <td>28Aug2021</td>\n",
              "      <td>7596828</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>37</th>\n",
              "      <td>25Aug2021</td>\n",
              "      <td>5419064</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>38</th>\n",
              "      <td>21Aug2021</td>\n",
              "      <td>4061448</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>39</th>\n",
              "      <td>18Aug2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>40</th>\n",
              "      <td>14Aug2021</td>\n",
              "      <td>11165532</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>41</th>\n",
              "      <td>11Aug2021</td>\n",
              "      <td>8817804</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>42</th>\n",
              "      <td>07Aug2021</td>\n",
              "      <td>7357979</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>43</th>\n",
              "      <td>04Aug2021</td>\n",
              "      <td>5158495</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>44</th>\n",
              "      <td>31Jul2021</td>\n",
              "      <td>3800000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>45</th>\n",
              "      <td>28Jul2021</td>\n",
              "      <td>5162779</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>46</th>\n",
              "      <td>24Jul2021</td>\n",
              "      <td>3800000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>47</th>\n",
              "      <td>21Jul2021</td>\n",
              "      <td>2000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>48</th>\n",
              "      <td>17Jul2021</td>\n",
              "      <td>20000000</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>49</th>\n",
              "      <td>14Jul2021</td>\n",
              "      <td>5143792</td>\n",
              "    </tr>\n",
              "    <tr>\n",
              "      <th>50</th>\n",
              "      <td>10Jul2021</td>\n",
              "      <td>3800000</td>\n",
              "    </tr>\n",
              "  </tbody>\n",
              "</table>\n",
              "</div>\n",
              "      <button class=\"colab-df-convert\" onclick=\"convertToInteractive('df-cc5eaaf8-b2eb-4be8-b3ea-bf197a85a030')\"\n",
              "              title=\"Convert this dataframe to an interactive table.\"\n",
              "              style=\"display:none;\">\n",
              "        \n",
              "  <svg xmlns=\"http://www.w3.org/2000/svg\" height=\"24px\"viewBox=\"0 0 24 24\"\n",
              "       width=\"24px\">\n",
              "    <path d=\"M0 0h24v24H0V0z\" fill=\"none\"/>\n",
              "    <path d=\"M18.56 5.44l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94zm-11 1L8.5 8.5l.94-2.06 2.06-.94-2.06-.94L8.5 2.5l-.94 2.06-2.06.94zm10 10l.94 2.06.94-2.06 2.06-.94-2.06-.94-.94-2.06-.94 2.06-2.06.94z\"/><path d=\"M17.41 7.96l-1.37-1.37c-.4-.4-.92-.59-1.43-.59-.52 0-1.04.2-1.43.59L10.3 9.45l-7.72 7.72c-.78.78-.78 2.05 0 2.83L4 21.41c.39.39.9.59 1.41.59.51 0 1.02-.2 1.41-.59l7.78-7.78 2.81-2.81c.8-.78.8-2.07 0-2.86zM5.41 20L4 18.59l7.72-7.72 1.47 1.35L5.41 20z\"/>\n",
              "  </svg>\n",
              "      </button>\n",
              "      \n",
              "  <style>\n",
              "    .colab-df-container {\n",
              "      display:flex;\n",
              "      flex-wrap:wrap;\n",
              "      gap: 12px;\n",
              "    }\n",
              "\n",
              "    .colab-df-convert {\n",
              "      background-color: #E8F0FE;\n",
              "      border: none;\n",
              "      border-radius: 50%;\n",
              "      cursor: pointer;\n",
              "      display: none;\n",
              "      fill: #1967D2;\n",
              "      height: 32px;\n",
              "      padding: 0 0 0 0;\n",
              "      width: 32px;\n",
              "    }\n",
              "\n",
              "    .colab-df-convert:hover {\n",
              "      background-color: #E2EBFA;\n",
              "      box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);\n",
              "      fill: #174EA6;\n",
              "    }\n",
              "\n",
              "    [theme=dark] .colab-df-convert {\n",
              "      background-color: #3B4455;\n",
              "      fill: #D2E3FC;\n",
              "    }\n",
              "\n",
              "    [theme=dark] .colab-df-convert:hover {\n",
              "      background-color: #434B5C;\n",
              "      box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);\n",
              "      filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));\n",
              "      fill: #FFFFFF;\n",
              "    }\n",
              "  </style>\n",
              "\n",
              "      <script>\n",
              "        const buttonEl =\n",
              "          document.querySelector('#df-cc5eaaf8-b2eb-4be8-b3ea-bf197a85a030 button.colab-df-convert');\n",
              "        buttonEl.style.display =\n",
              "          google.colab.kernel.accessAllowed ? 'block' : 'none';\n",
              "\n",
              "        async function convertToInteractive(key) {\n",
              "          const element = document.querySelector('#df-cc5eaaf8-b2eb-4be8-b3ea-bf197a85a030');\n",
              "          const dataTable =\n",
              "            await google.colab.kernel.invokeFunction('convertToInteractive',\n",
              "                                                     [key], {});\n",
              "          if (!dataTable) return;\n",
              "\n",
              "          const docLinkHtml = 'Like what you see? Visit the ' +\n",
              "            '<a target=\"_blank\" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'\n",
              "            + ' to learn more about interactive tables.';\n",
              "          element.innerHTML = '';\n",
              "          dataTable['output_type'] = 'display_data';\n",
              "          await google.colab.output.renderOutput(dataTable, element);\n",
              "          const docLink = document.createElement('div');\n",
              "          docLink.innerHTML = docLinkHtml;\n",
              "          element.appendChild(docLink);\n",
              "        }\n",
              "      </script>\n",
              "    </div>\n",
              "  </div>\n",
              "  "
            ],
            "text/plain": [
              "         Date Jackpot(£)\n",
              "0   01Jan2022    4201355\n",
              "1   29Dec2021    2000000\n",
              "2   25Dec2021   15000000\n",
              "3   22Dec2021    5472566\n",
              "4   18Dec2021    4082078\n",
              "5   15Dec2021    2000000\n",
              "6   11Dec2021   11704275\n",
              "7   08Dec2021    9035615\n",
              "8   04Dec2021    7547238\n",
              "9   01Dec2021    5364290\n",
              "10  27Nov2021    4015362\n",
              "11  24Nov2021    2000000\n",
              "12  20Nov2021    4026102\n",
              "13  17Nov2021    2000000\n",
              "14  13Nov2021    4101869\n",
              "15  10Nov2021    2000000\n",
              "16  06Nov2021   20000000\n",
              "17  03Nov2021    2000000\n",
              "18  30Oct2021   11042269\n",
              "19  27Oct2021    8714754\n",
              "20  23Oct2021    7265148\n",
              "21  20Oct2021    5107865\n",
              "22  16Oct2021    3800000\n",
              "23  13Oct2021    2000000\n",
              "24  09Oct2021   11836281\n",
              "25  06Oct2021    9052462\n",
              "26  02Oct2021    7569060\n",
              "27  29Sep2021    5370436\n",
              "28  25Sep2021    4048514\n",
              "29  22Sep2021    2000000\n",
              "30  18Sep2021   15000000\n",
              "31  15Sep2021    5383627\n",
              "32  11Sep2021    4079277\n",
              "33  08Sep2021    2000000\n",
              "34  04Sep2021   20000000\n",
              "35  01Sep2021    9079487\n",
              "36  28Aug2021    7596828\n",
              "37  25Aug2021    5419064\n",
              "38  21Aug2021    4061448\n",
              "39  18Aug2021    2000000\n",
              "40  14Aug2021   11165532\n",
              "41  11Aug2021    8817804\n",
              "42  07Aug2021    7357979\n",
              "43  04Aug2021    5158495\n",
              "44  31Jul2021    3800000\n",
              "45  28Jul2021    5162779\n",
              "46  24Jul2021    3800000\n",
              "47  21Jul2021    2000000\n",
              "48  17Jul2021   20000000\n",
              "49  14Jul2021    5143792\n",
              "50  10Jul2021    3800000"
            ]
          },
          "metadata": {},
          "execution_count": 7
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "df.to_csv('Week7/ScraperNatLotData.csv')"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 312
        },
        "id": "SAUkuMeqvQpX",
        "outputId": "453796ef-74ed-4431-e224-3cf4f1b16f05"
      },
      "execution_count": 19,
      "outputs": [
        {
          "output_type": "error",
          "ename": "FileNotFoundError",
          "evalue": "ignored",
          "traceback": [
            "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
            "\u001b[0;31mFileNotFoundError\u001b[0m                         Traceback (most recent call last)",
            "\u001b[0;32m<ipython-input-19-7de5ccdc00b9>\u001b[0m in \u001b[0;36m<module>\u001b[0;34m()\u001b[0m\n\u001b[0;32m----> 1\u001b[0;31m \u001b[0mdf\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mto_csv\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m'Week7/ScraperNatLotData.csv'\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m",
            "\u001b[0;32m/usr/local/lib/python3.7/dist-packages/pandas/core/generic.py\u001b[0m in \u001b[0;36mto_csv\u001b[0;34m(self, path_or_buf, sep, na_rep, float_format, columns, header, index, index_label, mode, encoding, compression, quoting, quotechar, line_terminator, chunksize, date_format, doublequote, escapechar, decimal, errors)\u001b[0m\n\u001b[1;32m   3168\u001b[0m             \u001b[0mdecimal\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mdecimal\u001b[0m\u001b[0;34m,\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m   3169\u001b[0m         )\n\u001b[0;32m-> 3170\u001b[0;31m         \u001b[0mformatter\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0msave\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m   3171\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m   3172\u001b[0m         \u001b[0;32mif\u001b[0m \u001b[0mpath_or_buf\u001b[0m \u001b[0;32mis\u001b[0m \u001b[0;32mNone\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;32m/usr/local/lib/python3.7/dist-packages/pandas/io/formats/csvs.py\u001b[0m in \u001b[0;36msave\u001b[0;34m(self)\u001b[0m\n\u001b[1;32m    188\u001b[0m                 \u001b[0mencoding\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mencoding\u001b[0m\u001b[0;34m,\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    189\u001b[0m                 \u001b[0merrors\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0merrors\u001b[0m\u001b[0;34m,\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 190\u001b[0;31m                 \u001b[0mcompression\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mdict\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mcompression_args\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mmethod\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mself\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mcompression\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m,\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m    191\u001b[0m             )\n\u001b[1;32m    192\u001b[0m             \u001b[0mclose\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0;32mTrue\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;32m/usr/local/lib/python3.7/dist-packages/pandas/io/common.py\u001b[0m in \u001b[0;36mget_handle\u001b[0;34m(path_or_buf, mode, encoding, compression, memory_map, is_text, errors)\u001b[0m\n\u001b[1;32m    491\u001b[0m         \u001b[0;32mif\u001b[0m \u001b[0mencoding\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    492\u001b[0m             \u001b[0;31m# Encoding\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0;32m--> 493\u001b[0;31m             \u001b[0mf\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mopen\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0mpath_or_buf\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mmode\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mencoding\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0mencoding\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0merrors\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0merrors\u001b[0m\u001b[0;34m,\u001b[0m \u001b[0mnewline\u001b[0m\u001b[0;34m=\u001b[0m\u001b[0;34m\"\"\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m    494\u001b[0m         \u001b[0;32melif\u001b[0m \u001b[0mis_text\u001b[0m\u001b[0;34m:\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m    495\u001b[0m             \u001b[0;31m# No explicit encoding\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
            "\u001b[0;31mFileNotFoundError\u001b[0m: [Errno 2] No such file or directory: 'Week7/ScraperNatLotData.csv'"
          ]
        }
      ]
    },
    {
      "cell_type": "code",
      "source": [
        "os.getcwd()"
      ],
      "metadata": {
        "colab": {
          "base_uri": "https://localhost:8080/",
          "height": 35
        },
        "id": "jzZpZ2RMu0eZ",
        "outputId": "2860bc0b-2945-4a5e-bd06-939baf276fbb"
      },
      "execution_count": 12,
      "outputs": [
        {
          "output_type": "execute_result",
          "data": {
            "application/vnd.google.colaboratory.intrinsic+json": {
              "type": "string"
            },
            "text/plain": [
              "'/content'"
            ]
          },
          "metadata": {},
          "execution_count": 12
        }
      ]
    }
  ]
}