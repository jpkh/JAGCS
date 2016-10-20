#ifndef NETWORK_SETTINGS_PRESENTER_H
#define NETWORK_SETTINGS_PRESENTER_H

#include "base_presenter.h"

namespace presentation
{
    class NetworkSettingsPresenter: public BasePresenter
    {
        Q_OBJECT

    public:
        explicit NetworkSettingsPresenter(QObject* view);
        ~NetworkSettingsPresenter() override;

    protected:
        void connectView(QObject* view) override;

    private slots:
        void updateProxy();

        void onApply();
        void onRestore();

    private:
        class Impl;
        Impl* const d;
    };
}

#endif // NETWORK_SETTINGS_PRESENTER_H
