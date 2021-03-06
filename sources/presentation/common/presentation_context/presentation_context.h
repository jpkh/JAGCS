#ifndef PRESENTATION_CONTEXT_H
#define PRESENTATION_CONTEXT_H

// Internal
#include "base_presenter.h"

class QQmlContext;
class QQuickView;

namespace presentation
{
    class PresentationContext
    {
        PresentationContext();

    public:
        ~PresentationContext();
        static PresentationContext* instance();

        static QObject* rootView();
        static QQmlContext* rootContext();

        static void load();
        static void show();
        static void saveGeometry();

    private:
        QQuickView* m_view;

        Q_DISABLE_COPY(PresentationContext)
    };
}

#endif // PRESENTATION_CONTEXT_H
