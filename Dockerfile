# Используем официальный образ Node.js
FROM node:20

# Устанавливаем переменную окружения для хранения пути к приложению
ENV APP_HOME /usr/src/app

# Создаем рабочую директорию внутри контейнера
WORKDIR $APP_HOME

# Устанавливаем Yarn
RUN corepack enable && corepack prepare yarn@stable --activate

# Копируем файл package.json и yarn.lock (если есть) в рабочую директорию
COPY package.json ./
COPY yarn.lock ./

# Устанавливаем все зависимости
RUN yarn install --frozen-lockfile

# Копируем весь исходный код в рабочую директорию
COPY . .

# Выполняем команду сборки
RUN yarn build

# Указываем команду запуска приложения
CMD ["yarn", "start"]
