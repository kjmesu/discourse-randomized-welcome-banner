import { apiInitializer } from "discourse/lib/api";
import { settings } from "virtual:theme";
import i18n from "discourse-i18n";
import { sanitize } from "discourse/lib/text";
import { prioritizeNameFallback } from "discourse/lib/settings";

export default apiInitializer((api) => {
  api.modifyClass("component:welcome-banner", (Superclass) =>
    class extends Superclass {
      get userType() {
        if (!this.currentUser) {
          return "anonymous";
        }
        return !this.currentUser.previous_visit_at ? "new_members" : "logged_in";
      }

      getRandomMessage(settingValue) {
        if (!settingValue) {
          return null;
        }

        const pool = settingValue
          .split("|")
          .filter((msg) => msg.trim().length > 0);

        if (pool.length === 0) {
          return null;
        }

        const randomIndex = Math.floor(Math.random() * pool.length);
        return pool[randomIndex].trim();
      }

      get headerText() {
        if (!settings.enable_randomized_banner) {
          return super.headerText;
        }

        const userType = this.userType;
        const settingMap = {
          new_members: settings.random_banner_new_members,
          logged_in: settings.random_banner_logged_in,
          anonymous: settings.random_banner_anonymous,
        };

        const randomMessage = this.getRandomMessage(settingMap[userType]);

        if (randomMessage) {
          const site_name = this.siteSettings.title || "";

          let args;
          if (!this.currentUser) {
            args = { site_name };
          } else {
            args = {
              site_name,
              preferred_display_name: sanitize(
                prioritizeNameFallback(
                  this.currentUser.name,
                  this.currentUser.username
                )
              ),
            };
          }

          return i18n(randomMessage, args);
        }

        return super.headerText;
      }
    }
  );
});
