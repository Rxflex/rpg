# Используем официальный образ Node.js как базовый
FROM node:20

# Устанавливаем переменную окружения для хранения пути к приложению
ENV APP_HOME /usr/src/app

# Создаем рабочую директорию внутри контейнера
WORKDIR $APP_HOME

# Копируем файл package.json и yarn.lock (если есть) в рабочую директорию
COPY package.json ./
COPY yarn.lock ./

# Устанавливаем Yarn по указанной версии в package.json
RUN corepack enable
RUN corepack prepare yarn@$(node -p "require('./package.json').packageManager.split('@')[1]") --activate

# Устанавливаем все зависимости
RUN yarn install --immutable

# Копируем весь исходный код в рабочую директорию
COPY . .

# Выполняем команду сборки
RUN yarn build

# Указываем команду запуска приложения
CMD ["yarn", "start"]
