#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QObject>
#include <QMap>

class Translator : public QObject
{
    Q_OBJECT
public:
    explicit Translator(QObject *parent = nullptr);
    Q_INVOKABLE QString encodeMorse(const QString &text);
    Q_INVOKABLE QString decodeMorse(const QString &text);

signals:

private:
    QString encodeToken(const QString &token);
    QString decodeToken(const QString &token);
    QMap<QString, QString> letters2Morse_
    {
        {"A", ".-"},
        {"B", "-..."},
        {"C", "-.-."},
        {"D", "-.."},
        {"E", "."},
        {"F", "..-."},
        {"G", "--."},
        {"H", "...."},
        {"I", ".."},
        {"J", ".---"},
        {"K", "-.-"},
        {"L", ".-.."},
        {"M", "--"},
        {"N", "-."},
        {"O", "---"},
        {"P", ".--."},
        {"Q", "--.-"},
        {"R", ".-."},
        {"S", "..."},
        {"T", "-"},
        {"U", "..-"},
        {"V", "...-"},
        {"W", ".--"},
        {"X", "-..-"},
        {"Y", "-.--"},
        {"Z", "--.."},
        {",", "--..--"},
        {".", ".-.-.-"},
    };
    QMap<QString, QString> morse2Letters_;

};

#endif // TRANSLATOR_H
